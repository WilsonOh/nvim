local navic = require("nvim-navic")

if navic then
  navic.setup({highlight = false, separator = " > ", depth_limit = 3, depth_limit_indicator = ".."})
end
