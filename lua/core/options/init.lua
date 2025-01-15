local tabwidth = 2

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.hidden = true
vim.opt.pumheight = 10
vim.opt.fileencoding = "utf-8"
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.conceallevel = 3
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 100
vim.opt.background = "dark"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.mouse = "a"
vim.opt.laststatus = 3
vim.opt.smoothscroll = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = tabwidth
vim.opt.softtabstop = tabwidth
vim.opt.shiftwidth = tabwidth
vim.opt.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.foldlevel = 99
