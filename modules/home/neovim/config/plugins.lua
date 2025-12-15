-- modules/home/neovim/lua/plugins.lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = "NvimTreeToggle",
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
      "hrsh7th/nvim-cmp",
      -- etc.
    },
    config = function()
      -- Configuration logic here
    end
  },

  -- Import another module for a cleaner structure (R5)
  -- { import = "plugins.telescope" }, 
}
