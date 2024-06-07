require('format-on-save').setup({})

local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

local if_file_exists = require("format-on-save.formatters.if-file-exists")

local eslint = if_file_exists({
  pattern = ".eslintrc.*",
  formatter = formatters.custom({
    format = function(lines)
      vim.cmd.EslintFixAll()
      return vim.api.nvim_buf_get_lines(0, 0, -1, false)
    end
  })
})

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    css = formatters.lsp,
    html = formatters.lsp,
    java = formatters.lsp,
    json = formatters.lsp,
    lua = formatters.lsp,
    markdown = formatters.prettierd,
    openscad = formatters.lsp,
    python = formatters.lsp,
    rust = formatters.lsp,
    scad = formatters.lsp,
    scss = formatters.lsp,
    sh = formatters.shfmt,
    terraform = formatters.lsp,
    javascript = eslint,
    typescript = eslint,
    typescriptreact = eslint,
    yaml = formatters.lsp,
    go = formatters.lsp,
  },
  -- Optional: fallback formatter to use when no formatters match the current filetype
  -- fallback_formatter = {
  --   formatters.remove_trailing_whitespace,
  --   formatters.remove_trailing_newlines,
  --   formatters.prettierd,
  -- },
  -- By default, all shell commands are prefixed with "sh -c" (see PR #3)
  -- To prevent that set `run_with_sh` to `false`.
  -- run_with_sh = false,
})
