local languages = {
  "bash", "c", "css", "dart", "go", "html", "javascript", "json", "lua",
  "markdown", "markdown_inline", "php", "php_only", "python", "query",
  "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({})
      ts.install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then
            return
          end
          local ok, added = pcall(vim.treesitter.language.add, lang)
          if not ok or not added then
            return
          end
          vim.treesitter.start(args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      K("n", "<leader>ti", ":InspectTree<CR>", { silent = true })
      K("n", "<leader>th", ":Inspect<CR>", { silent = true })
    end
  },
}
