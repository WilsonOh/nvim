local nvimtree = Vapour.utils.plugins.require 'nvim-tree'

local nvimtree_width = math.ceil(vim.api.nvim_win_get_width(0) * 0.2)

nvimtree.setup {
  filters = { custom = { '*.tmp', '.git' } },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = true,
  ignore_ft_on_setup = { 'dashboard' },
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {},
  },
  view = { width = nvimtree_width, side = 'left', mappings = { custom_only = false, list = {} } },
  renderer = {
    indent_markers = { enable = true, icons = { corner = '└ ', edge = '│ ', none = '  ' } },
  },
}
vim.cmd [[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]
