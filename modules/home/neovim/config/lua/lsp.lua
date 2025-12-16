-- modules/home/neovim/config/lua/lsp.lua
-- Neovim 0.11+ native LSP configuration (NO nvim-lspconfig)

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- =========================
-- ON_ATTACH
-- =========================

local on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "K", vim.lsp.buf.hover, "Hover Docs")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>d", vim.diagnostic.open_float, "Line Diagnostic")
end

-- =========================
-- LSP SERVER DEFINITIONS
-- =========================

vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}

-- =========================
-- ENABLE SERVERS
-- =========================

vim.lsp.enable({
    "rust_analyzer",
    "clangd",
    "pyright",
    "lua_ls",
})

-- =========================
-- INLAY HINTS
-- =========================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

-- =========================
-- SAFE FORMAT ON SAVE
-- =========================

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if client.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format({ async = false })
                return
            end
        end
    end,
})
