require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    preserve_window_proportions = false,
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "<F5>", action = "change_root" },
      },
    },
  },
  git = {
    ignore = false
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false
      }
    }
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

K("n", "<A-b>", ":NvimTreeFindFile<CR>")
