local M = {
  {
    "mbbill/undotree",
    config = function()
      K("n", "<leader>u", vim.cmd.UndotreeShow)
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      K("n", "<leader>gs", vim.cmd.Git)
    end
  },
  {
    'APZelos/blamer.nvim',
    config = function()
      vim.g.blamer_enabled = 1
    end
  },
  {
    'rhysd/git-messenger.vim',
    config = function()
      vim.g.git_messenger_floating_win_opts = { border = 'single' }
      vim.g.git_messenger_popup_content_margins = true
      vim.g.git_messenger_always_into_popup = true
      K("n", "<leader>gm", vim.cmd.GitMessenger)
    end
  },
}

return M

