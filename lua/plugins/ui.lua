return {
  {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      { "SmiteshP/nvim-navic" },
    },
    config = function()
      require("nvim-navic").setup {
        lsp = {
          auto_attach = true,
        },
      }
      require("breadcrumbs").setup()
    end
  },
  { 
    'nvim-lualine/lualine.nvim',
    config = function()
      local custom_gruvbox = require('lualine.themes.gruvbox')
      custom_gruvbox.normal.c.bg = 'NONE'
      custom_gruvbox.inactive.c.bg = 'NONE'
      custom_gruvbox.insert.c.bg = 'NONE'
      custom_gruvbox.visual.c.bg = 'NONE'
      custom_gruvbox.replace.c.bg = 'NONE'
      custom_gruvbox.command.c.bg = 'NONE'
      
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = custom_gruvbox,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'dashboard', 'alpha', 'starter' },
            winbar = { 'help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree', 'Trouble', 'alpha', 'lir', 'Outline', 'spectre_panel', 'toggleterm', 'oil' },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str)
                if str == 'NORMAL' then
                  return '🅽 '
                elseif str == 'INSERT' then
                  return '🆔 '
                elseif str == 'VISUAL' then
                  return '🆅 '
                elseif str == 'V-LINE' then
                  return '🆅 L'
                elseif str == 'V-BLOCK' then
                  return '🆅 B'
                elseif str == 'COMMAND' then
                  return '🅲 '
                elseif str == 'TERMINAL' then
                  return '🆃 '
                else
                  return str
                end
              end,
            },
          },
          lualine_b = {
            { 'branch', icon = '' },
            {
              'diff',
              colored = true,
              diff_color = {
                added = 'LuaLineDiffAdd',
                modified = 'LuaLineDiffChange',
                removed = 'LuaLineDiffDelete',
              },
              symbols = { added = ' ', modified = ' ', removed = ' ' },
            },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
          },
          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 40,
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = ' ',
                newfile = ' 🆕',
              },
            },
          },
          lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
            function()
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return ''
              end
              local c = {}
              for _, client in pairs(clients) do
                table.insert(c, client.name)
              end
              return ' ' .. table.concat(c, '|')
            end,
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end
  },
  {
    "startup-nvim/startup.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("startup").setup({theme = "startify"})
    end
  },
}

