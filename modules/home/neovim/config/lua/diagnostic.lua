-- Change the Diagnostic symbols in the sign column (gutter)
local tools = _G.tools or { ui = { icons = {} }, hl_str = function(_, s) return s end }
local icons = tools.ui.icons or {}

local hl = vim.api.nvim_set_hl
-- Red
hl(0, "DiagnosticVirtualTextError", { fg = "#E82424", bg = "#3c1f1f" })
hl(0, "DiagnosticSignError",        { fg = "#E82424" })
-- Orange
hl(0, "DiagnosticVirtualTextWarn",  { fg = "#FF9E3B", bg = "#332b1a" })
hl(0, "DiagnosticSignWarn",         { fg = "#FF9E3B" })
-- Blue
hl(0, "DiagnosticVirtualTextInfo",  { fg = "#658594", bg = "#1d2b33" })
hl(0, "DiagnosticSignInfo",         { fg = "#658594" })
-- Aqua/Green
hl(0, "DiagnosticVirtualTextHint",  { fg = "#87a987", bg = "#1e2b26" })
hl(0, "DiagnosticSignHint",         { fg = "#87a987" })

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
        prefix = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then return icons.dot
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then return icons.dot
            end
            return " "
        end,
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
