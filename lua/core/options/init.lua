local tabwidth = 2

vim.g.VM_leader = "<Bslash>"

vim.g.VM_maps = {
  ["Add Cursor Down"] = "<C-j>",
  ["Add Cursor Up"] = "<C-k>",
  ["Add Cursor At Pos"] = "<C-Space>",
  ["I BS"] = "",
}

vim.cmd("filetype plugin indent on")
vim.o.shortmess = vim.o.shortmess .. "cW"
vim.o.hidden = true
vim.o.whichwrap = "b,s,<,>,[,],h,l"
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.conceallevel = 3
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 100
vim.o.background = "dark"
-- vim.o.clipboard = 'unnamedplus'
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.mouse = "a"
vim.o.laststatus = 3
-- vim.o.cmdheight = 0

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
--[[ vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()' ]]

vim.o.tabstop = tabwidth
vim.bo.tabstop = tabwidth
vim.o.softtabstop = tabwidth
vim.bo.softtabstop = tabwidth
vim.o.shiftwidth = tabwidth
vim.bo.shiftwidth = tabwidth
vim.o.autoindent = true
vim.o.smartindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

vim.g.c_syntax_for_h = 1
vim.g.vim_markdown_folding_disabled = true

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
