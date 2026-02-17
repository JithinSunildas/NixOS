local on_attach = function(client, bufnr)
    -- Wrapper to make mapping easier: map(keys, func, description)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = desc })
    end

    -- NAVIGATION
    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("gr", vim.lsp.buf.references, "Goto References")

    -- HELP / DOCS
    map("gh", vim.lsp.buf.hover, "LSP Hover Docs") -- Replaces 'K'
    map("K", function()
        local word = vim.fn.expand("<cword>")
        pcall(vim.cmd, "vertical Man " .. word)
    end, "System Man Page (Split)")

    -- ACTIONS
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action (Quick Fix)")
    map("<leader>rn", vim.lsp.buf.rename, "Smart Rename")
    map("<leader>cf", function() vim.lsp.buf.format { async = true } end, "Format File")

    -- DIAGNOSTICS JUMPING
    map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
    map("[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Prev Error")
    map("]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next Error")
end
-- Change the Diagnostic symbols in the sign column (gutter)
local tools = _G.tools or { ui = { icons = {} }, hl_str = function(_, s) return s end }
local icons = tools.ui.icons or {}
local signs = { Error = icons.dot, Warn = icons.dot, Hint = icons.dot, Info = icons.dot }

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
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
