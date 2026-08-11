require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'base16',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'alpha' },
      winbar = {},
    },
    ignore_focus = { 'NvimTree' },
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16,
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
      },
      {
        '',
        draw_empty = true,
      },
    },
    lualine_b = {
      {
        'filename',
        symbols = { modified = 'MO', readonly = 'RO' },
      },
      {
        '  ',
        draw_empty = true,
      },
    },
    lualine_c = {
      {
        'branch',
        icon = '',
        colored = true,
      },
      {
        'diff',
        colored = false,
        diff_color = {
          added    = 'LuaLineDiffAdd',
          modified = 'LuaLineDiffChange',
          removed  = 'LuaLineDiffDelete',
        },
        symbols = { added = '+', modified = '~', removed = '-' },
      },
    },
    lualine_x = {
      {
        function()
          local clients = {}
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(clients, client.name)
          end
          return #clients > 0 and table.concat(clients, ', ') or ''
        end,
        icon = ' ',
      },
      {
        'diagnostics',
        sources = { 'nvim_lsp', 'nvim_diagnostic', 'coc' },
        symbols = {
          error = '󰅙',
          warn = '',
          info = '',
          hint = '󰌵',
        },
        diagnostics_color = {
          color_error = { fg = 'red' },
          color_warn = { fg = 'yellow' },
          color_info = { fg = 'cyan' },
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    },
    lualine_y = {
      {
        'encoding',
      },
    },
    lualine_z = {
      { 'progress' },
      { 'location' },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {},
  tabline = {},
  winbar = {},
  extensions = {},
}
