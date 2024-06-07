vim.g.git_messenger_floating_win_opts = { border = 'single' }
vim.g.git_messenger_popup_content_margins = true
vim.g.git_messenger_always_into_popup = true

vim.keymap.set("n", "<leader>gm", vim.cmd.GitMessenger)
