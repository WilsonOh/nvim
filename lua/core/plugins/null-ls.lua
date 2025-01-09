local M = {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  enabled = true,
}

M.config = function()
  local null_ls = require("null-ls")

  local formatting = null_ls.builtins.formatting

  -- local diag = null_ls.builtins.diagnostics

  local ca = null_ls.builtins.code_actions

  local js_opts = {
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file({ "package.json", "deno.json" })
    end,
  }

  local sources = {
    --[[ diag.flake8.with({
      extra_args = { "--max-line-length", "120", "--extend-ignore", "E203" },
    }),
    formatting.black.with({
      extra_args = { "--line-length", "120" },
    }),
    formatting.gofmt,
    formatting.stylua,
    formatting.cbfmt,
    formatting.clang_format.with({
      filetypes = { "java" },
    }),
    formatting.prettierd.with(js_opts),
    diag.cppcheck, ]]
    require("none-ls.diagnostics.eslint_d").with(js_opts),

    -- diag.fish,
    -- require("typescript.extensions.null-ls.code-actions"),
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
