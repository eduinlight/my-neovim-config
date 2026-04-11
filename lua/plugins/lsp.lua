local M = {
  { "mason-org/mason.nvim",             opts = {} },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'mfussenegger/nvim-lint' },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'eslint',
          'html',
          'tailwindcss',
        },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local bufopts = { noremap = true, silent = true, buffer = ev.buf }
          K('n', '<leader>[d', function() vim.diagnostic.goto_prev() end, bufopts)
          K('n', '<leader>]d', function() vim.diagnostic.goto_next() end, bufopts)
          K('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
          K('n', 'K', vim.lsp.buf.hover, bufopts)
          K('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
          K('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          K('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          K('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          K('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          K('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
          K('n', '<F2>', vim.lsp.buf.rename, bufopts)
          K('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        end,
      })

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('eslint', {
        settings = {
          codeActionOnSave = {
            mode = "all"
          },
        },
      })

      vim.lsp.config('html', {
        filetypes = { "html", "templ", "htmldjango", "twig" },
      })

      vim.lsp.config('tailwindcss', {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
              },
            },
          },
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable({ 'eslint', 'html', 'dartls', 'tailwindcss', 'lua_ls' })

      local builtin = require("telescope.builtin")
      vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
      vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions

      K('n', '<A-f>', vim.cmd.EslintFixAll)
      K('n', '<leader>f', function()
        local ft = vim.bo.filetype
        if ft == 'typescript' or ft == 'typescriptreact' or ft == 'javascript' or ft == 'javascriptreact' then
          vim.cmd('!biome format --write ' .. vim.fn.expand('%'))
          vim.cmd('edit!')
        else
          vim.lsp.buf.format { async = true }
        end
      end)
      K('n', '<leader>dv', ":vsplit<CR><C-w>lgD", { silent = true })
      K('n', '<leader>ds', ":split<CR><C-w>jgD", { silent = true })
      K('n', '<leader>js', ":ClangdSwitchSourceHeader<CR>", { silent = true })
      K('n', '<leader>ct', function() vim.diagnostic.open_float({ "line" }) end, { silent = true })

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end
        },
      })
    end
  },
  { 'rafamadriz/friendly-snippets' },
}

return M
