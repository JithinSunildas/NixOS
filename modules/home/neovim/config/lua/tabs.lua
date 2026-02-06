-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''    -- Use default tabline (empty string uses built-in)

-- Pin a buffer to a tab
local pinned_tabs = {}

local function toggle_pin_buffer()
    local tab = vim.api.nvim_get_current_tabpage()
    local buf = vim.api.nvim_get_current_buf()

    if pinned_tabs[tab] == buf then
        pinned_tabs[tab] = nil
        print("Tab unpinned")
    else
        pinned_tabs[tab] = buf
        print("Tab pinned to buffer: " .. vim.fn.bufname(buf))
    end
end

-- Prevention Logic
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local tab = vim.api.nvim_get_current_tabpage()
        local buf = vim.api.nvim_get_current_buf()
        local pinned_buf = pinned_tabs[tab]

        if pinned_buf and buf ~= pinned_buf then
            -- If we navigated away, go back and open the new buffer in a vertical split instead
            vim.cmd("buffer " .. pinned_buf)
            vim.cmd("vsplit " .. vim.fn.bufname(buf))
            print("Tab is pinned! Opening in split instead.")
        end
    end
})

vim.keymap.set('n', '<leader>tp', toggle_pin_buffer, { desc = 'Toggle [T]ab [P]in' })

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
