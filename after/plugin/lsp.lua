local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.preset('recommended')

lsp.set_preferences({
  sign_icons = {}
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'html',
    'cssls',
    'rust_analyzer',
    'eslint'
  },
  handlers = {
    lsp.default_setup,
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
  }
}

lspconfig.html.setup {
  filetypes = { "html", "templ", "htmldjango", "twig" }
}

-- DART
lspconfig.dartls.setup({
  on_attach = on_attach,
  flags = lsp_flags
})

lspconfig.tailwindCSS.setup({
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

-- USE telescope to listing references
local builtin = require("telescope.builtin")
vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions

-- MAPS
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

-- SELECT COMPLETION
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
