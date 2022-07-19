local colorscheme = 'catppuccin'
local transparent_bg = false

-- General
require('core.options')
require('core.plugins')
require('core.keybindings')

require('colorscheme.' .. colorscheme)

-- LSP and Autocomplete
require('language-servers')

-- Source all global functions
require('globals')

-- Whichkey
require('which-key-config')

if transparent_bg then vim.cmd('hi Normal guibg=NONE ctermbg=NONE') end
