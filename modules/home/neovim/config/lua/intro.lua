-- Disable default intro
vim.opt.shortmess:append("I")

local function show_welcome()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'welcome')

    local welcome_text = {
        " _____ ___ _  ___   _    _    ____   ___   ___  __  __",
        "|_   _|_ _| |/ / | | |  / \\  | __ ) / _ \\ / _ \\|  \\/  |",
        "  | |  | || ' /| |_| | / _ \\ |  _ \\| | | | | | | |\\/| |",
        "  | |  | || . \\|  _  |/ ___ \\| |_) | |_| | |_| | |  | |",
        "  |_| |___|_|\\_\\_| |_/_/   \\_\\____/ \\___/ \\___/|_|  |_|",
        "",
        "                   Press <leader>f to find files",
        "                   Press <leader>f to live grep",
        "                   Press <leader>tn for a new buffer",
        "                   Press :q to close this window",
        "",
    }

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, welcome_text)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_set_current_buf(buf)

    -- Center the text
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':quit<CR>', { noremap = true, silent = true })
end

-- Show welcome screen when starting without files
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            show_welcome()
        end
    end
})
