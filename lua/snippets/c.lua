local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local rep = require("luasnip.extras").rep

return {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }), s("std", {
    c(1, { t({ "int main(void) {", "\t" }), t({ "int main(int argc, char **argv) {", "\t" }) }, {}), i(2),
    t({ "", "}" })
  }), s("inc", {
    t("#include "), c(1, {
      sn(nil, { t("<"), i(1, "header file"), t(">") }), sn(nil, { t('"'), i(1, "header file"), t('"') })
    }, {})
  }), s("ifndef", fmt("#ifndef {}\n#define {}\n\n{}\n\n#endif // !{}",
    { i(1, "HEADER GUARD"), rep(1), i(0), rep(1) })),
}
