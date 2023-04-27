--
-- This function has been generated from your
--   view.mappings.list
--   view.mappings.custom_only
--   remove_keymaps
--
-- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
--
-- Although care was taken to ensure correctness and completeness, your review is required.
--
-- Please check for the following issues in auto generated content:
--   "Mappings removed" is as you expect
--   "Mappings migrated" are correct
--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  K('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  K('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  K('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  K('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  K('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  K('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  K('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  K('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  K('n', '<CR>', api.node.open.edit, opts('Open'))
  K('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  K('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  K('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  K('n', '.', api.node.run.cmd, opts('Run Command'))
  K('n', '-', api.tree.change_root_to_parent, opts('Up'))
  K('n', 'a', api.fs.create, opts('Create'))
  K('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  K('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  K('n', 'c', api.fs.copy.node, opts('Copy'))
  K('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  K('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  K('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  K('n', 'd', api.fs.remove, opts('Delete'))
  K('n', 'D', api.fs.trash, opts('Trash'))
  K('n', 'E', api.tree.expand_all, opts('Expand All'))
  K('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  K('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  K('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  K('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  K('n', 'f', api.live_filter.start, opts('Filter'))
  K('n', 'g?', api.tree.toggle_help, opts('Help'))
  K('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  K('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  K('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  K('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  K('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  K('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  K('n', 'o', api.node.open.edit, opts('Open'))
  K('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  K('n', 'p', api.fs.paste, opts('Paste'))
  K('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  K('n', 'q', api.tree.close, opts('Close'))
  K('n', 'r', api.fs.rename, opts('Rename'))
  K('n', 'R', api.tree.reload, opts('Refresh'))
  K('n', 's', api.node.run.system, opts('Run System'))
  K('n', 'S', api.tree.search_node, opts('Search'))
  K('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  K('n', 'W', api.tree.collapse_all, opts('Collapse'))
  K('n', 'x', api.fs.cut, opts('Cut'))
  K('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  K('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  K('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  K('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH


  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  K('n', 'u', api.tree.change_root_to_parent, opts('Up'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  view = {
    preserve_window_proportions = false,
    adaptive_size = true,
  },
  git = {
    ignore = false
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false
      }
    }
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

K("n", "<A-b>", ":NvimTreeFindFile<CR>")
