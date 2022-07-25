_G.P = function(s)
  vim.pretty_print(s)
end

local api = vim.api

_G.test = function()
  P(api.nvim_get_current_line())
  -- api.nvim_put({ 'testing', 'lmao' }, '', true, true)
  api.nvim_set_current_line('lmao')
end

_G.set_colorscheme = function(colorscheme, transparent_bg)
  vim.cmd.packadd(colorscheme)
  pcall(require, 'colorschemes.' .. colorscheme)
  vim.cmd.colorscheme(colorscheme)
  if transparent_bg then vim.cmd('hi Normal guibg=NONE ctermbg=NONE') end
end
