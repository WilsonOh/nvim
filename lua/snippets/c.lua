local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
  s('ternary', {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, 'cond'), t(' ? '), i(2, 'then'), t(' : '), i(3, 'else'),
  }),
  s({ name = 'Main Function Template for C', trig = 'main', dscr = 'The main function template' }, {
    c(1, { t({ 'int main(void) {', '\t' }), t({ 'int main(int argc, char **argv) {', '\t' }) }, {}),
    i(0), t({ '', '}' }),
  }), s('inc', {
    t('#include '),
    c(1, { sn(nil, { t('<'), i(1), t('>') }), sn(nil, { t('"'), i(1), t('"') }) }, {}),
  }), s('ifndef', fmt('#ifndef {}\n#define {}\n\n{}\n\n#endif // !{}',
                      { i(1, 'HEADER GUARD'), rep(1), i(0), rep(1) })),
}
