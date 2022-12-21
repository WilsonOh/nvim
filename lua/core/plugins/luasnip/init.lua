local M = {
	"L3MON4D3/LuaSnip",

	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}

M.config = function()
	local ls = require("luasnip")

	local set = vim.keymap.set
	local opts = { silent = true }

	set("i", "<c-p>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end, opts)

	ls.add_snippets("c", require("core.plugins.luasnip.c"))

	ls.add_snippets("cpp", vim.list_extend(require("core.plugins.luasnip.c"), require("core.plugins.luasnip.cpp")))

	ls.add_snippets("python", require("core.plugins.luasnip.python"))

	ls.add_snippets("lua", require("core.plugins.luasnip.lua"))

	ls.add_snippets("rust", require("core.plugins.luasnip.rust"))

	ls.add_snippets("cmake", require("core.plugins.luasnip.cmake"))
end

return M
