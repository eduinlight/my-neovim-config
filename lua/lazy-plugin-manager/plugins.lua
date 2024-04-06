local lazy = require("lazy")

lazy.setup(
  {
    {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
    },
    -- neodev for type checking
    "folke/neodev.nvim",
    -- telescope
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope-dap.nvim",
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
      end,
    },
    --themes
    "ellisonleao/gruvbox.nvim",
    { 'rose-pine/neovim', as = 'rose-pine' },
    -- uitils
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
    { "mbbill/undotree" },
    "tpope/vim-fugitive",
    { "folke/todo-comments.nvim",         dependencies = "nvim-lua/plenary.nvim" },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    -- Lint
    { 'mfussenegger/nvim-lint' },
    -- Formatters
    { 'mhartington/formatter.nvim' },
    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    'APZelos/blamer.nvim',
    -- gitlens like
    'rhysd/git-messenger.vim',
    -- dashboard
    {
      "startup-nvim/startup.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    -- comments
    'numToStr/Comment.nvim',
    -- status bar
    'itchyny/lightline.vim',
    -- files explorer
    'kyazdani42/nvim-tree.lua',
    -- lsp support for nvim-tree
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      }
    },
    -- icons
    'kyazdani42/nvim-web-devicons',
    -- multiple cursors
    { 'mg979/vim-visual-multi', branch = 'master' },
    -- c/c++/bash/llvm debugger
    'sakhnik/nvim-gdb',
    -- debugger
    { "rcarriga/nvim-dap-ui",   dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    -- surround ys cs ds
    { "kylechui/nvim-surround", version = "*",                                                      event = "VeryLazy" },
    -- format on save
    "elentok/format-on-save.nvim",
    -- Norg
    {
      "nvim-neorg/neorg",
      dependencies = { "luarocks.nvim" },
      lazy = false,
      version = "*",
      -- config = true
    },
    -- markdown-preview
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
    }

  })
