vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "gruvbox-material",
    callback = function()
        local hl = vim.api.nvim_set_hl
        
        -- ERROR: Dragon Red (Punchy)
        hl(0, "DiagnosticError", { fg = "#E82424", bold = true })
        hl(0, "DiagnosticSignError", { fg = "#E82424" })

        -- WARN: Gruvbox Orange (Distinct from Error)
        hl(0, "DiagnosticWarn", { fg = "#fe8019", bold = true })
        hl(0, "DiagnosticSignWarn", { fg = "#fe8019" })

        -- INFO: Gruvbox Blue (Cool & calm)
        hl(0, "DiagnosticInfo", { fg = "#83a598" })
        hl(0, "DiagnosticSignInfo", { fg = "#83a598" })

        -- HINT: Gruvbox Aqua/Green (Subtle but different)
        hl(0, "DiagnosticHint", { fg = "#8ec07c" })
        hl(0, "DiagnosticSignHint", { fg = "#8ec07c" })
        
        -- Force the virtual text (inline hints) to use these colors too
        hl(0, "DiagnosticVirtualTextError", { fg = "#E82424", bg = "#3c1f1f" })
        hl(0, "DiagnosticVirtualTextWarn",  { fg = "#fe8019", bg = "#332b1a" })
        hl(0, "DiagnosticVirtualTextInfo",  { fg = "#83a598", bg = "#1d2b33" })
        hl(0, "DiagnosticVirtualTextHint",  { fg = "#8ec07c", bg = "#1e2b26" })
    end,
})
