local null_ls = require("null-ls")

local lsp_utils = require("language-servers.utils")

if not null_ls then
  return
end

local formatting = null_ls.builtins.formatting

local diag = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local ca = null_ls.builtins.code_actions

local sources = {
  formatting.gofmt,
  formatting.stylua,
  formatting.black,
  diag.flake8,
  formatting.cmake_format,
  formatting.cbfmt,
  formatting.prettier,
  diag.eslint,
  ca.eslint,
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
  on_attach = function(client, bufnr)
    lsp_utils.get_null_ls_sources()
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_utils.filtered_formatters(bufnr)
        end,
      })
    end
  end,
})
