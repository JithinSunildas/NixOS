-- modules/home/neovim/config/lsp.lua

local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Define the servers you want Mason to ensure are installed
local servers = {
  'rust_analyzer', -- For Rust (your favorite!)
  'clangd',        -- For C/C++
  'nil_ls',        -- For Nix expressions (super helpful!)
  'pyright',       -- For Python
  'jdtls',         -- For Java
  'lua_ls',        -- For Neovim config (essential)
}

-- Key setup function that runs when an LSP server is attached to a buffer
local on_attach = function(client, bufnr)
  -- Customize how specific servers interact (e.g., enable format-on-save for some)
  -- if client.name == 'rust_analyzer' then
  --   client.server_capabilities.documentFormattingProvider = true
  -- end

  -- Set up keymaps that are local to the buffer being edited (bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  
  -- Example LSP keymaps (these would ideally be in keymaps.lua, but are shown here for context):
  map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
end

-- --- 1. MASON Setup ---
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- --- 2. MASON-LSPCONFIG BRIDGE ---
mason_lspconfig.setup({
  ensure_installed = servers,
  -- This is the magic part: It calls lsp_config.SERVER.setup for every installed server
  handlers = {
    -- Default setup for all servers installed by Mason
    function (server_name)
      lsp_config[server_name].setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        -- Add any server-specific settings here, e.g.,
        -- settings = {
        --   pyright = { ... }
        -- }
      })
    end,
    
    -- Specific handler for 'lua_ls' to include your config directory
    ['lua_ls'] = function ()
      lsp_config.lua_ls.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          Lua = {
            -- Ensure Neovim knows about your custom modules
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
    end
  }
})

-- NOTE: If you have your own keymaps module, ensure it is set up to load the on_attach function keymaps!
