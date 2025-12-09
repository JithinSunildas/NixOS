-- modules/home/neovim/plugins/dashboard.lua

local dashboard = require("dashboard")
local dashboard = require("dashboard.themes.dashboard")

-- Header definition
dashboard.section.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[  ████████╗ ██╗ ██╗  ██╗ ██╗  ██╗  █████╗  ██████╗   ██████╗  ███╗   ███╗ ]],
	[[  ╚══██╔══╝ ██║ ██║ ██╔╝ ██║  ██║ ██╔══██╗ ██╔══██╗ ██╔═══██╗ ████╗ ████║ ]],
	[[     ██║    ██║ █████╔╝  ███████║ ███████║ ██████╔╝ ██║   ██║ ██╔████╔██║ ]],
	[[     ██║    ██║ ██╔═██╗  ██╔══██║ ██╔══██║ ██╔══██╗ ██║   ██║ ██║╚██╔╝██║ ]],
	[[     ██║    ██║ ██║  ██╗ ██║  ██║ ██║  ██║ ██████╔╝ ╚██████╔╝ ██║ ╚═╝ ██║ ]],
	[[     ╚═╝    ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═════╝   ╚═════╝  ╚═╝     ╚═╝ ]],
	[[                                                                       ]],
	[[  "If you don't like the road you're walking, start paving another one." ]],
	[[                                                           — Dolly Parton ]],
}

-- Button definitions
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Config", ":e ~/.config/home-manager/modules/neovim/init.lua <CR>"),
	dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Footer definition
local function footer()
	local total_plugins = require("lazy").stats().count
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	return datetime .. "   " .. total_plugins .. " plugins"
end

dashboard.section.footer.val = footer()

-- Setup function for the dashboard theme
dashboard.setup(dashboard.opts)

-- Disable folding on dashboard buffer
vim.cmd([[autocmd FileType dashboard setlocal nofoldenable]])
