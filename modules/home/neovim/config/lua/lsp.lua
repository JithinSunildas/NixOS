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
  "ocamllsp",
  "ts_ls",
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
      checkOnSave = {
        command = "clippy",
      },
      imports = {
        granularity = { group = "module" },
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

vim.lsp.config.ts_ls = {
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
