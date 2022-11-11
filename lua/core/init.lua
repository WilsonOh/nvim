-- General
require("core.options")
require("core.plugins")
require("core.keybindings")

-- LSP and Autocomplete
require("language-servers")

-- Source all global functions
require("globals")

-- Souce all autocommands
require("autocmds")

-- Global helper function for setting colorschemes (calling packadd and colorscheme cmds)
-- Second optional parameter sets transparent background if true
require("globals").set_colorscheme("catppuccin")
