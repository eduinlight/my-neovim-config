vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 50

vim.opt.errorbells = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.wrap = false
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.directory = os.getenv("HOME") .. "/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
vim.opt.colorcolumn = { ctermbg = 0, guibg = "lightgrey" }

vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

-- vim.opt.bs = 2
vim.opt.autoread = true
vim.opt.autowrite = true

vim.g.sessions_dir = os.getenv("HOME") .. "/.vim-sessions"

vim.g.rust_recommended_style = 0

-- vim.g.clipboard = {
--   name = 'WslClipboard',
--   copy = {
--     ["+"] = 'clip.exe',
--     ["*"] = 'clip.exe',
--   },
--   paste = {
--     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }
