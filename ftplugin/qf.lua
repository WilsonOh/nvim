local set = vim.keymap.set
local opts = { silent = true }

set('n', '<leader>c', '<cmd>cclose<CR>', opts)
set('n', '<leader>n', '<cmd>cnext<CR><cmd>copen<CR>', opts)
set('n', '<leader>N', '<cmd>cprev<CR><cmd>copen<CR>', opts)
set('n', '<leader>F', '<cmd>cfirst<CR><cmd>copen<CR>', opts)
set('n', '<leader>L', '<cmd>clast<CR><cmd>copen<CR>', opts)
