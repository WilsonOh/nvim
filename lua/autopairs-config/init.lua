local npairs = Vapour.utils.plugins.packadd('nvim-autopairs', true)

if not npairs then return end

-- if remap == nil then return end

npairs.setup({
  break_line_filetype = nil,
  check_ts = true,
  enable_check_bracket_line = true,
  fast_wrap = {},
})

local remap = vim.keymap.set
_G.MUtils = {}

if Vapour.plugins.lsp.enabled == true then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
else
  MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
      return npairs.esc("<cr>")
    else
      return npairs.autopairs_cr()
    end
  end

  remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
end
