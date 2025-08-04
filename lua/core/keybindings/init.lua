local set = vim.keymap.set
local opts = { silent = true }

local is_quickfix_open = require("utils").is_quickfix_open

vim.g.mapleader = " "
vim.g.maplocalleader = " "

set("n", "<leader>i", "g~l", opts)

set("v", "J", ":m '>+1<CR>gv=gv", opts)
set("v", "K", ":m '<-2<CR>gv=gv", opts)
set("n", "J", "mzJ`z", opts)
set("n", "<C-d>", "<C-d>zz", opts)
set("n", "<C-u>", "<C-u>zz", opts)

set("n", "<Space>", "<NOP>", opts)

set("n", "<M-j>", function()
  if is_quickfix_open() then
    vim.cmd.cnext()
  end
end, opts)

set("n", "<M-k>", function()
  if is_quickfix_open() then
    vim.cmd.cprev()
  end
end, opts)

set("n", "<C-Left>", "<C-w>h", opts)
set("n", "<C-Down>", "<C-w>j", opts)
set("n", "<C-Up>", "<C-w>k", opts)
set("n", "<C-Right>", "<C-w>l", opts)

set("n", "<Tab>", ":bnext<CR>", opts)
set("n", "<S-Tab>", ":bprevious<CR>", opts)

set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

-- set("i", "<C-h>", "<Left>", opts)
-- set("i", "<C-l>", "<Right>", opts)

-- Open Telescope Menu
set("n", "<leader>T", ":Telescope<CR>", opts)

-- Normal Mode New Line
set("n", "<leader>o", "o<esc>k", opts)
set("n", "<leader>O", "O<esc>j", opts)

-- Whole Word Find and Replace
-- set('n', '<leader>s', [[:%s/\<\>/<Left><Left><Left>]], opts)

-- N jumping
set("n", "n", "nzzzv", opts)
set("n", "N", "Nzzzv", opts)
set("n", "J", "mzJ`z", opts)

-- Moving Text
set("v", "J", [[:m '>+1<CR>gv=gv]], opts)

-- Undo Break Points
set("i", ",", ",<C-g>u", opts)
set("i", ".", ".<C-g>u", opts)
set("i", "!", "!<C-g>u", opts)
set("i", "?", "?<C-g>u", opts)
set("i", ";", ";<C-g>u", opts)

-- Save File
set("n", "<C-s>", function()
  vim.cmd("silent write")
end, opts)

-- Move out of Terminal
set("t", "<C-d>", "<C-Bslash><C-n>:bd!<CR>", opts)
set("t", "<C-w>", "<C-Bslash><C-n><C-w>", opts)

-- Insert mode Mappings
set("i", "<C-e>", "<esc>A", opts)
set("i", "<C-a>", "<esc>I", opts)

set("n", "gd", "0D", opts)
set("n", "gC", "0C", opts)

-- Copy entire buffer to system clipboard

-- smart dd
local smart_dd = function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end
set("n", "dd", smart_dd, { expr = true })

-- blackhole delete/change
set("n", "dD", '"_dd')
set("n", "cC", '"_cc')

-- Search within visual selection
set("x", "/", "<Esc>/\\%V", opts)

set("n", "<C-o>", "<C-o>zz", opts)

set({ "x", "v" }, "<leader>y", [["+y]], opts)
set("n", "<leader>a", "ggVG", { desc = "Select Entire Buffer" })
set("c", "<C-a>", "<Home>")
