local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({
  sign_icons = {}
})

lsp.ensure_installed({
  'html',
  'cssls',
  'tsserver',
  'rust_analyzer',
  'eslint'
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

require 'lspconfig'.eslint.setup {
  capabilities = capabilities,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
  }
}

-- DART
require('lspconfig')['dartls'].setup({
  on_attach = on_attach,
  flags = lsp_flags
})

lsp.setup()

-- USE telescome to listing references
local builtin = require("telescope.builtin")
vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions

-- MAPS
K('n', '<A-f>', vim.cmd.EslintFixAll)
K('n', '<leader>f', function() vim.lsp.buf.format { async = true } end)
K('n', '<leader>dv', ":vsplit<CR><C-w>lgD", { silent = true })
K('n', '<leader>ds', ":split<CR><C-w>jgD", { silent = true })
K('n', '<leader>js', ":ClangdSwitchSourceHeader<CR>", { silent = true })

-- SELECT COMPLETION
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})
