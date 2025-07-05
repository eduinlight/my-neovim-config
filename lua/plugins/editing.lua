local M = {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()
      local api = require("Comment.api")
      K("n", "<A-c>", api.toggle.linewise.current)
      K('v', '<A-c>', api.call('toggle.linewise', 'g@'), { expr = true })
    end
  },
  { 'mg979/vim-visual-multi', branch = 'master' },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
}

return M
