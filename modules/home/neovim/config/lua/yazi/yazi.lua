local yazi_win = nil
local yazi_buf = nil

local function toggle_yazi_sidebar()
    -- 1. Toggle off if already open
    if yazi_win and vim.api.nvim_win_is_valid(yazi_win) then
        vim.api.nvim_win_close(yazi_win, true)
        yazi_win = nil
        return
    end

    local chooser_file = vim.fn.tempname()

    -- 2. Create the vertical split
    vim.cmd("topleft 60vsplit")
    yazi_win = vim.api.nvim_get_current_win()

    -- 3. Create a dedicated empty buffer for the terminal
    yazi_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(yazi_win, yazi_buf)

    -- Clean up UI
    vim.wo[yazi_win].number = false
    vim.wo[yazi_win].relativenumber = false
    vim.wo[yazi_win].signcolumn = "no"

-- The actual, correct path with the "s" in modules
    local yazi_config_dir = vim.fn.expand("~/nix-config/modules/home/neovim/config/lua/yazi")

    local cmd = {
        "yazi",
        "--chooser-file=" .. chooser_file
    }


    vim.fn.termopen(cmd, {
        env = { YAZI_CONFIG_HOME = yazi_config_dir }, 
        on_exit = function()
            vim.defer_fn(function()
                if yazi_win and vim.api.nvim_win_is_valid(yazi_win) then
                    vim.api.nvim_win_close(yazi_win, true)
                    yazi_win = nil
                end
                if yazi_buf and vim.api.nvim_buf_is_valid(yazi_buf) then
                    vim.api.nvim_buf_delete(yazi_buf, { force = true })
                    yazi_buf = nil
                end

                local f = io.open(chooser_file, "r")
                if f then
                    local chosen = f:read("*a"):gsub("%s+", "")
                    f:close()
                    os.remove(chooser_file)
                    if chosen ~= "" then
                        vim.cmd("edit " .. vim.fn.fnameescape(chosen))
                    end
                end
            end, 10)
        end
    })
    vim.cmd("startinsert") 
end

vim.keymap.set("n", "<leader>e", toggle_yazi_sidebar, { desc = "Toggle Yazi Sidebar" })
