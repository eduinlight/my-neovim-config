local M = {
  { "mason-org/mason.nvim",             opts = {} },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
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
      local lspconfig = require('lspconfig')

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'eslint',
          'html',
          'tailwindcss',
        },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        K('n', '[d', vim.diagnostic.goto_prev, bufopts)
        K('n', ']d', vim.diagnostic.goto_next, bufopts)
        K('n', 'gD', vim.lsp.buf.declaration, bufopts)
        K('n', 'gd', vim.lsp.buf.definition, bufopts)
        K('n', 'K', vim.lsp.buf.hover, bufopts)
        K('n', 'gi', vim.lsp.buf.implementation, bufopts)
        K('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        K('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        K('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        K('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        K('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        K('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        K('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        K('n', 'gr', vim.lsp.buf.references, bufopts)
      end

      local lsp_flags = {
        debounce_text_changes = 150,
      }

      lspconfig.eslint.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        settings = {
          codeActionOnSave = {
            mode = "all"
          },
        }
      }

      lspconfig.html.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { "html", "templ", "htmldjango", "twig" }
      }

      lspconfig.dartls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
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

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
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
      }

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
