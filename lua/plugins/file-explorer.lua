local M = {
  {
    'stevearc/oil.nvim',
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
          signcolumn = "yes:2",
        },
        keymaps = {
          ["<C-c>"] = false,
          ["<C-l>"] = false,
          ["<C-r>"] = "actions.refresh",
          ["<leader>ff"] = "actions.select_split",
          ["<leader>fv"] = "actions.select_vsplit",
          ["<leader>ft"] = "actions.select_tab",
          ["<leader>fp"] = "actions.preview",
          ["<leader>fc"] = "actions.close",
          ["<leader>fr"] = "actions.refresh",
          ["<leader>fs"] = {
            "actions.change_sort",
            opts = {
              toggle = true,
            },
          },
        },
        use_default_keymaps = true,
      })

      K("n", "<A-b>", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
    end
  },
  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
}

return M
