local M = {
	"jose-elias-alvarez/null-ls.nvim",
}

M.config = function()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting

	local diag = null_ls.builtins.diagnostics

	local ca = null_ls.builtins.code_actions

	local js_opts = {
		prefer_local = "node_modules/.bin",
		condition = function(utils)
			return utils.root_has_file({ "package.json", "deno.json" })
		end,
	}

	local sources = {
		formatting.gofmt,
		formatting.stylua,
		formatting.black,
		diag.flake8,
		formatting.cbfmt,
		formatting.prettierd.with(js_opts),
		diag.eslint_d.with(js_opts),
		ca.eslint_d.with(js_opts),
	}

	null_ls.setup({
		sources = sources,
		root_dir = require("null-ls.utils").root_pattern(
			".null-ls-root",
			"Makefile",
			".git",
			"package.json",
			"deno.json",
			"Cargo.toml"
		),
	})
end

return M
