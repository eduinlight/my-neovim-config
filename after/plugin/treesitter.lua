require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "javascript", "typescript", "clojure", "cmake", "css", "html", "graphql", "java", "json", "latex", "kotlin", "make", "elixir", "python", "regex", "scss", "sql", "yaml", "toml", "vim", "vue", "dart", "dockerfile", "cpp", "c_sharp", "bash", "php" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  }
}

-- jump to context
K("n", "<leader>jc", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

vim.treesitter.language.register('html', 'xml')
