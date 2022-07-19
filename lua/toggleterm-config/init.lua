local toggleterm_height = math.ceil(vim.api.nvim_win_get_height(0) * 0.45)

require('toggleterm').setup {
  size = toggleterm_height,
  open_mapping = [[<c-\>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1',
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
}
