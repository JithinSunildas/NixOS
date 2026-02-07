-- modules/home/neovim/config/lua/lsp.lua
-- Neovim 0.11+ native LSP configuration

local api = vim.api
local lsp = vim.lsp

-- 1. Capabilities (Keep this, it's correct)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- 2. On Attach (Cleaned up)
local on_attach = function(client, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("gr", vim.lsp.buf.references, "References")
    map("K", vim.lsp.buf.hover, "Hover Docs")
    map("<leader>br", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<leader>d", vim.diagnostic.open_float, "Line Diagnostic")
end

-- 3. Diagnostic Signs (Using your existing tools global)
local tools = _G.tools or { ui = { icons = {} } }
local icons = tools.ui.icons
local signs = { Error = icons.dot or "E", Warn = icons.dot or "W", Hint = icons.dot or "H", Info = icons.dot or "I" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 4. Shared Config (Don't repeat yourself!)
local defaults = {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Helper to merge tables
local function make_config(custom_config)
    return vim.tbl_deep_extend("force", defaults, custom_config or {})
end

-- =========================
-- SERVER CONFIGURATIONS
-- =========================

lsp.config.nixd = make_config({
    cmd = { "nixd" },
    root_markers = { "flake.nix", ".git" },
})

lsp.config.rust_analyzer = make_config({
    cmd = { "rust-analyzer" },
    root_markers = { "Cargo.toml" },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            cargo = { buildScripts = { enable = true } },
        }
    }
})

lsp.config.clangd = make_config({
    cmd = { "clangd", "--background-index" },
    root_markers = { "compile_commands.json", ".git" },
})

lsp.config.pyright = make_config({
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml" },
})

lsp.config.lua_ls = make_config({
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

-- Renamed tsserver -> ts_ls (Standard for newer configs)
lsp.config.ts_ls = make_config({
    cmd = { "typescript-language-server", "--stdio" },
    root_markers = { "package.json", "tsconfig.json" },
})

lsp.config.gopls = make_config({
    cmd = { "gopls" },
    root_markers = { "go.work", "go.mod" },
})

lsp.config.zls = make_config({
    cmd = { "zls" },
    root_markers = { "build.zig" },
})

lsp.config.ocamllsp = make_config({
    cmd = { "ocamllsp" },
    root_markers = { "dune-project", "*.opam" },
})

lsp.config.html = make_config({ cmd = { "vscode-html-language-server", "--stdio" } })
lsp.config.cssls = make_config({ cmd = { "vscode-css-language-server", "--stdio" } })
lsp.config.tailwindcss = make_config({
    cmd = { "tailwindcss-language-server", "--stdio" },
    root_markers = { "tailwind.config.js", "tailwind.config.ts" },
})

-- =========================
-- AUTO-START LOGIC
-- =========================
-- In 0.11 native, you usually enable the servers you want.
-- If you are on a very specific nightly, your previous `vim.lsp.enable` might be needed.
-- But generally, we just let filetypes trigger it.

for server, config in pairs(lsp.config) do
    -- Enable all configured servers
    vim.lsp.enable(server)
end

-- =========================
-- FEATURES
-- =========================

-- Inlay Hints (Auto-enable on attach)
api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

-- Format on Save (Suckless Version)
api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
