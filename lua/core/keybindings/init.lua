local set = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader = " "

set("n", "<Space>", "<NOP>", opts)

set("i", "jk", "<ESC>")
set("i", "kj", "<ESC>")

set("n", "<M-j>", ":resize -2<CR>", opts)
set("n", "<M-k>", ":resize +2<CR>", opts)
set("n", "<M-h>", ":vertical resize -2<CR>", opts)
set("n", "<M-l>", ":vertical resize +2<CR>", opts)

set("n", "<C-Left>", "<C-w>h", opts)
set("n", "<C-Down>", "<C-w>j", opts)
set("n", "<C-Up>", "<C-w>k", opts)
set("n", "<C-Right>", "<C-w>l", opts)

set("n", "<Tab>", ":bnext<CR>", opts)
set("n", "<S-Tab>", ":bprevious<CR>", opts)

set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

set("x", "K", ":move '<-2<CR>gv-gv", opts)
set("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Open Telescope Menu
set("n", "<leader>T", ":Telescope<CR>", opts)

-- Normal Mode New Line
set("n", "<leader>o", "o<esc>k", opts)
set("n", "<leader>O", "O<esc>j", opts)
set("n", "<leader>D", "dd<leader>O<esc>", opts)

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
set("n", "<C-s>", ":w<CR>", opts)

-- Move out of Terminal
set("t", "<C-d>", "<C-Bslash><C-n>:bd!<CR>", opts)
set("t", "<C-w>", "<C-Bslash><C-n><C-w>", opts)

-- Normal Terminal
set("n", "T", ":vsplit<CR>:term<CR>a", opts)

-- Insert mode Mappings
set("i", "<C-e>", "<esc>A", opts)
set("i", "<C-a>", "<esc>I", opts)

set("n", "gd", "0D", opts)
set("n", "gC", "0C", opts)

-- Source Current Buffer
set("n", "<leader><leader>s", "<cmd>%so<CR>", opts)

-- Telescope utils test
set("n", "<leader>m", function()
  require("telescope_utils").custom_search()
end, opts)

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

set("i", "<M-e>", "<cmd>EmojiPicker<CR>")

vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')
vim.cmd([[vnoremap // y/\\V<C-R>=escape(@",\'/\\')<CR><CR>]])
