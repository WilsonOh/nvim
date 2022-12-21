-- General
require("core.options")
require("core.keybindings")
require("core.lazy")

-- Source all global functions
require("globals")

-- Souce all autocommands
require("autocmds")

-- Second optional parameter sets transparent background if true
require("globals").set_colorscheme("catppuccin")
