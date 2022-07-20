local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return { s('class', fmt('class {} {{\n\t{}\n}};', { i(1, vim.fn.expand('%:r')), i(2) })) }
