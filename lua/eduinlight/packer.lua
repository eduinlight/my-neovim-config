-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- neodev for type checking
  use "folke/neodev.nvim"

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-dap.nvim' } }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  --themes
  use { "ellisonleao/gruvbox.nvim" }
  use({ 'rose-pine/neovim', as = 'rose-pine' })

  use { 'nvim-treesitter/playground' }

  use { "xiyaowong/nvim-transparent" }

  use { "mbbill/undotree" }

  use { "iamcco/markdown-preview.nvim" }

  use { "tpope/vim-fugitive" }

  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- gitlens like
  use { 'APZelos/blamer.nvim' }
  use { 'rhysd/git-messenger.vim' }

  -- dashboard
  use {
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- comments
  use { 'numToStr/Comment.nvim' }

  -- status bar
  use { 'itchyny/lightline.vim' }

  -- files explorer
  use { 'kyazdani42/nvim-tree.lua' }

  -- icons
  use { 'kyazdani42/nvim-web-devicons' }

  -- multiple cursors
  use { 'mg979/vim-visual-multi' }

  -- c/c++/bash/llvm debugger
  use { 'sakhnik/nvim-gdb' }

  -- debugger
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
end)
