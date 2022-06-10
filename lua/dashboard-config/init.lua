vim.g.dashboard_custom_header = {
  [[██╗    ██╗██╗██╗     ███████╗ ██████╗ ███╗   ██╗]],
  [[██║    ██║██║██║     ██╔════╝██╔═══██╗████╗  ██║]],
  [[██║ █╗ ██║██║██║     ███████╗██║   ██║██╔██╗ ██║]],
  [[██║███╗██║██║██║     ╚════██║██║   ██║██║╚██╗██║]],
  [[╚███╔███╔╝██║███████╗███████║╚██████╔╝██║ ╚████║]],
  [[ ╚══╝╚══╝ ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝]],
}

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
  a = { description = { '  Find File          ' }, command = 'Telescope find_files' },
  d = { description = { '  Search Text        ' }, command = 'Telescope live_grep' },
  b = { description = { '  Recent Files       ' }, command = 'Telescope oldfiles' },
  e = { description = { '  Config             ' }, command = 'edit ~/.config/nvim/lua/vapour/user-config/init.lua' },
  f = { description = { '  Git                ' }, command = 'lua Vapour.plugins.toggleterm.toggle_lazygit()' }
}
vim.g.dashboard_custom_footer = { [[I really don't know what I'm doing :(]] }
