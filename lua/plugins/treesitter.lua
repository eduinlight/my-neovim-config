local M = {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()
      
      K("n", "<leader>jc", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true })
    end
  },
}

return M

