-- Change the Diagnostic symbols in the sign column (gutter)
local tools = _G.tools or { ui = { icons = {} }, hl_str = function(_, s) return s end }
local icons = tools.ui.icons or {}

local hl = vim.api.nvim_set_hl

local function apply_dragon_diagnostics()
    local dragon = {
        red    = "#e82424",
        orange = "#ff9e3b",
        blue   = "#658594",
        aqua   = "#87a987",
        green  = "#a9b665",
        bg_red = "#3c1f1f",
        bg_ora = "#332b1a",
        bg_blu = "#1d2b33",
        bg_grn = "#1e2b26",
    }

    hl(0, "DiagnosticError", { fg = dragon.red })
    hl(0, "DiagnosticWarn",  { fg = dragon.orange })
    hl(0, "DiagnosticInfo",  { fg = dragon.blue })
    hl(0, "DiagnosticHint",  { fg = dragon.aqua })
    hl(0, "DiagnosticOk",    { fg = dragon.green })

    hl(0, "DiagnosticFloatingError", { fg = dragon.red })
    hl(0, "DiagnosticFloatingWarn",  { fg = dragon.orange })
    hl(0, "DiagnosticFloatingInfo",  { fg = dragon.blue })
    hl(0, "DiagnosticFloatingHint",  { fg = dragon.aqua })
    hl(0, "DiagnosticFloatingOk",    { fg = dragon.green })

    hl(0, "DiagnosticVirtualTextError", { fg = dragon.red,    bg = dragon.bg_red, bold = true })
    hl(0, "DiagnosticVirtualTextWarn",  { fg = dragon.orange, bg = dragon.bg_ora, bold = false })
    hl(0, "DiagnosticVirtualTextInfo",  { fg = dragon.blue,   bg = dragon.bg_blu })
    hl(0, "DiagnosticVirtualTextHint",  { fg = dragon.aqua,   bg = dragon.bg_grn })

    local groups = { "Sign", "VirtualLines" }
    for _, type in ipairs(groups) do
        hl(0, "Diagnostic" .. type .. "Error", { link = "DiagnosticError" })
        hl(0, "Diagnostic" .. type .. "Warn",  { link = "DiagnosticWarn" })
        hl(0, "Diagnostic" .. type .. "Info",  { link = "DiagnosticInfo" })
        hl(0, "Diagnostic" .. type .. "Hint",  { link = "DiagnosticHint" })
        hl(0, "Diagnostic" .. type .. "Ok",    { link = "DiagnosticOk" })
    end

    hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = dragon.red })
    hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = dragon.orange })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function() apply_dragon_diagnostics() end,
})

apply_dragon_diagnostics()

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.dot,
            [vim.diagnostic.severity.WARN]  = icons.dot,
            [vim.diagnostic.severity.HINT]  = icons.dot,
            [vim.diagnostic.severity.INFO]  = icons.dot,
        },
    },
    virtual_text = {
        severity = { min = vim.diagnostic.severity.HINT },
        spacing = 4,
    },
    severity_sort = true,
    update_in_insert = false,
    underline = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
