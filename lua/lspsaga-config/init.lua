require('lspsaga').init_lsp_saga {
  border_style = 'double',
  symbol_in_winbar = { enable = true, right_align = true, show_file = false },
}
local action = require('lspsaga.action')
vim.keymap.set('n', '<C-p>', function()
  action.smart_scroll_with_saga(1)
end, { silent = true })
vim.keymap.set('n', '<C-l>', function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })
