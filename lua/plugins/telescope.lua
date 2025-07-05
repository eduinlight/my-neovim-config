local M = {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')
      local actions = require('telescope.actions')

      require('telescope').setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git",
            ".vscode",
            ".idea",
            "dist",
            "build",
            "target",
            "vendor"
          },
          mappings = {
            n = {
              ['<c-d>'] = actions.delete_buffer
            },
            i = {
              ['<C-u>'] = false,
              ['<c-d>'] = actions.delete_buffer
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      K('n', '<C-p>', builtin.git_files, {})
      K('n', '<leader>pf', builtin.find_files, {})
      K('n', '<leader>vh', builtin.help_tags, {})
      K('n', '<leader>pb', builtin.buffers, {})
      K('n', '<leader>lg', builtin.live_grep, {})
      K('n', '<leader>gs', builtin.git_status, {})
      K('n', '<leader>gb', builtin.git_branches, {})
      K('n', '<leader>gc', builtin.git_commits, {})
      K('n', '<leader>gbc', builtin.git_bcommits, {})

      require('telescope').load_extension('dap')
      K('n', '<leader>dc', '<cmd>Telescope dap commands<cr>')
      K('n', '<leader>dco', '<cmd>Telescope dap configurations<cr>')
      K('n', '<leader>dlb', '<cmd>Telescope dap list_breakpoints<cr>')
      K('n', '<leader>dv', '<cmd>Telescope dap variables<cr>')
      K('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
    end
  },
}

return M
