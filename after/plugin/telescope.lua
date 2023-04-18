local builtin = require('telescope.builtin')
K("n", "<C-p>", ":Telescope find_files prompt_prefix=🔍: sort_lastused=true<CR>")
K('n', '<leader>ff', builtin.git_files, {})
K('n', '<leader>fg', builtin.live_grep, {})
K('n', '<leader>fb', builtin.buffers, {})
K('n', '<leader>fh', builtin.help_tags, {})
K('n', '<leader>gs', builtin.git_status, {})
K('n', '<leader>gb', builtin.git_branches, {})
K('n', '<leader>gc', builtin.git_commits, {})
K('n', '<F3>', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
K("n", "<F12>", ":TodoTelescope keywords=TODO,FIX<CR>")

require('telescope').setup{
	defaults = {
		file_ignore_patterns = { "node_modules", "./node_modules", "./build", "./dist", "./.git", "./extern", "./vcpkg_installed", ".git", "dist" },
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false
		},
		find_files = {
			theme = "dropdown",
			hidden = true
		}
	}
}

