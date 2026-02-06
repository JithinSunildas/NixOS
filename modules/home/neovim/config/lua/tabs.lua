-- ============================================================================
-- TABS
-- ============================================================================

function _G.custom_tabline()
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        -- Select highlighting
        if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        -- Set the tab page number (used by mouse clicks)
        s = s .. '%' .. i .. 'T'
        -- Get the filename (just the tail, not full path)
        local buflist = vim.fn.tabpagebuflist(i)
        local winnr = vim.fn.tabpagewinnr(i)
        local bufnr = buflist[winnr]
        local filename = vim.fn.bufname(bufnr)
        -- Extract just the filename
        if filename == '' then
            filename = '[No Name]'
        else
            filename = vim.fn.fnamemodify(filename, ':t') -- :t gets tail (filename only)
        end
        local modified = vim.fn.getbufvar(bufnr, "&modified") == 1 and '+' or ''

        s = s .. ' ' .. i .. ': ' .. filename .. modified .. ' '
    end
    s = s .. '%#TabLineFill#%T'
    return s
end

-- Tab display settings
vim.opt.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''    -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Alternative navigation (more intuitive)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<Tab>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<S-Tab>', ':tabmove -1<CR>', { desc = 'Move tab left' })

-- Function to open file in new tab
local function open_file_in_tab()
    vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
        if input and input ~= '' then
            vim.cmd('tabnew ' .. input)
        end
    end)
end

-- Function to duplicate current tab
local function duplicate_tab()
    local current_file = vim.fn.expand('%:p')
    if current_file ~= '' then
        vim.cmd('tabnew ' .. current_file)
    else
        vim.cmd('tabnew')
    end
end

-- Function to close tabs to the right
local function close_tabs_right()
    local current_tab = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr('$')

    for i = last_tab, current_tab + 1, -1 do
        vim.cmd(i .. 'tabclose')
    end
end

-- Function to close tabs to the left
local function close_tabs_left()
    local current_tab = vim.fn.tabpagenr()

    for i = current_tab - 1, 1, -1 do
        vim.cmd('1tabclose')
    end
end

-- Enhanced keybindings
vim.keymap.set('n', '<leader>tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', '<leader>tL', close_tabs_left, { desc = 'Close tabs to the left' })

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
    local buffers_in_tab = #vim.fn.tabpagebuflist()
    if buffers_in_tab > 1 then
        vim.cmd('bdelete')
    else
        -- If it's the only buffer in tab, close the tab
        vim.cmd('tabclose')
    end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })
