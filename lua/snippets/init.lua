local ls = require "luasnip"

local set = vim.keymap.set
local opts = { silent = true }

set('i', '<c-l>', function()
  if ls.choice_active() then ls.change_choice(1) end
end, opts)

ls.add_snippets("c", require('snippets.c'))

ls.add_snippets("cpp", require('snippets.c'))

ls.add_snippets("python", require('snippets.python'))

ls.add_snippets("lua", require('snippets.lua'))

ls.add_snippets("rust", require('snippets.rust'))