local M = {
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "*",
    config = function()
      local neorg = require('neorg')
      neorg.setup({
        load = {
          ["core.defaults"] = {},
          ["core.keybinds"] = { config = { default_keybinds = true, neorg_leader = " " } },
          ["core.concealer"] = {},
          ["core.qol.todo_items"] = {},
          ["core.dirman"] = { config = { workspaces = { notes = "~/notes" } } },
        }
      })
      K("n", "<F10>", function()
        vim.cmd("Neorg workspace notes")
      end)
    end
  },
  {
    "Imamiland/neovim-vivify-markdown.nvim",
    version = "stable",
    config = function()
      require("neovim-vivify-markdown").setup({})
    end
  },
}

return M
