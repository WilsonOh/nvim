local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s("class", fmt("class {} {{\n\t{}\n}};", { i(1, vim.fn.expand("%:r")), i(2) })),
	s(
		{ name = "for loop", trig = "for", dscr = "choice snippet for normal/range based for loop" },
		c(1, {
			fmt("for (auto &{} : {}) {{\n\t{}\n}}", { i(1), i(2), i(3) }),
			fmt("for (int i = {}; i < {}; ++i){{\n\t{}\n}}", { i(1), i(2), i(3) }),
		}, {})
	),

	s(
		{ name = "const for loop", trig = "cfor", dscr = "choice snippet for const range based for loop" },
		fmt("for (const auto &{} : {}) {{\n\t{}\n}}", { i(1, "init"), i(2, "end"), i(3) })
	),
	s("st", t("std::size_t ")),
	s("ifmt", fmt("#include <fmt/core.h>\n#include <fmt/ranges.h>", {})),
}
