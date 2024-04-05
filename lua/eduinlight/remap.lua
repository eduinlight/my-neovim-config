K("n", "<leader>w", ":w<CR>")
K("n", "<leader>q", ":q<CR>")

-- jump between windows
K("n", "<leader>h", ":wincmd h<CR>")
K("n", "<leader>j", ":wincmd j<CR>")
K("n", "<leader>k", ":wincmd k<CR>")
K("n", "<leader>l", ":wincmd l<CR>")

-- increase decrease windows size
K("n", "<leader>+", ":vertical resize +5<CR>", { silent = true })
K("n", "<leader>-", ":vertical resize -5<CR>", { silent = true })

-- repeat current line
K("n", "<A-r>", ":t .<CR>")

-- move current line
K("n", "<A-k>", ":m .-2<CR>==")
K("n", "<A-j>", ":m .+1<CR>==")

-- never press Q
K("n", "Q", "<nop>")

-- jump between buffers
K("n", "(", ":bn<CR>")
K("n", ")", ":bp<CR>")
K("n", "_", ":b#<CR>")

-- delete not cut
K({ "n", "v" }, "d", '"_d')
K({ "n", "v" }, "dd", '"_dd')
