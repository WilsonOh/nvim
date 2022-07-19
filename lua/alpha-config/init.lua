local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- Set header
dashboard.section.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}

local opts = { silent = true }

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>', opts),
  dashboard.button('f', '  > Find file', ':Telescope find_files<CR>', opts),
  dashboard.button('c', '  > Search Configs',
                   ':Telescope find_files cwd=~/.config/nvim/lua/<CR>', opts),
  dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>', opts),
  dashboard.button('s', '  > Settings', ':e ~/.config/nvim/lua/core/init.lua<CR>', opts),
  dashboard.button('q', '  > Quit NVIM', ':qa<CR>', opts),
}

dashboard.section.footer.val = 'I really don\'t know what I\'m doing 😔'

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
