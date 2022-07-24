local colorscheme = 'catppuccin'
local transparent_bg = false

-- General
require('core.options')
require('core.plugins')
require('core.keybindings')

require('colorschemes.' .. colorscheme)

-- LSP and Autocomplete
require('language-servers')

-- Source all global functions
require('globals')

if transparent_bg then vim.cmd('hi Normal guibg=NONE ctermbg=NONE') end
