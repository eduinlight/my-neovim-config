local neorg = require("neorg")

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = " ",
        hook = function(keybinds)
          keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_cycle")
        end,
      },
    },
    ["core.concealer"] = {},
    ["core.qol.todo_items"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes"
        }
      }
    },
  }
})

-- MAPS
K("n", "<F10>", ":Neorg workspace notes<CR>")
