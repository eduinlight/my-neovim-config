return {
  { 
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.g.gruvbox_transparent_bg = 1
      vim.cmd.colorscheme("gruvbox")
      vim.cmd [[highlight Normal guibg=NONE ]]
      vim.cmd [[highlight NonText guibg=NONE]]
      vim.cmd [[highlight SignColumn guibg=NONE]]
    end
  },
}