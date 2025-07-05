local M = {
  'stevearc/conform.nvim',
}

M.config = function()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort" },
      rust = { "rustfmt" },
      javascript = { "biome", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

return M
