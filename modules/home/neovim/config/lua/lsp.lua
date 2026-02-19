-- modules/home/neovim/config/lua/lsp.lua
-- Neovim 0.11+ native LSP configuration (NO nvim-lspconfig)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- =========================
-- ON_ATTACH
-- =========================

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
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

-- =========================
-- COMPLETEOPT (IMPORTANT FOR CMP + TAB)
-- =========================

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- =========================
-- ENABLE SERVERS
-- =========================

vim.lsp.enable({
    "nixd",
    "rust_analyzer",
    "clangd",
    "pyright",
    "lua_ls",
    "jdtls",
    "haskell_language_server",
    "gopls",
    "zls",
    "tinymist",
    "ocamllsp",
    "tsserver",
    "tailwindcss",
    "cssls",
    "emmet_ls",
    "html"
})

-- =========================
-- LSP SERVER DEFINITIONS
-- =========================

vim.lsp.config.haskell_language_server = {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    root_markers = {
        "stack.yaml",
        "cabal.project",
        "*.cabal",
        "hie.yaml",
        ".git",
    },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = true,
            },
            imports = {
                granularity = { group = "module", "unlinked-file" },
                prefix = "self",
            },
            cargo = {
                buildScripts = { enable = true },
            },
            procMacro = { enable = true },
        }
    }
}

vim.lsp.config.clangd = {
    cmd = {
        "clangd",
        "--background-index",
        "--query-driver=/run/current-system/sw/bin/g++,/run/current-system/sw/bin/gcc",
    },
    filetypes = { "c", "h", "hpp", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.jdtls = {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_markers = { "pom.xml", "gradle.build", ".git", "build.gradle" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        java = {
            format = {
                enabled = true,
                settings = {
                    url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
        },
    },
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

vim.lsp.config.tinymist = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    -- These markers help your system find the project root
    root_markers = { "typst.toml", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = true,
    settings = {
        exportPdf = "onType",
        outputPath = "$root/target/$name",
        formatterMode = "typstyle",
    }
}

vim.lsp.config.zls = {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "build.zig", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.ocamllsp = {
    cmd = { "ocamllsp" },
    filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_markers = { "*.opam", "dune-project", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

-- =========================
-- WEB DEVELOPMENT
-- =========================

require("luasnip.loaders.from_vscode").lazy_load()

vim.lsp.config.emmet_ls = {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" },
    root_markers = { ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.nixd = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.tailwindcss = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte", "vue" },
    root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    capabilities = capabilities,
    on_attach = on_attach,
}

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
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format({ async = false, id = client.id })
                return
            end
        end
    end,
})
