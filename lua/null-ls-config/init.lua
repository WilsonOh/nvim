local null_ls = require('null-ls')

local lsp_utils = require('language-servers.utils')

if not null_ls then return end

local formatting = null_ls.builtins.formatting

local diag = null_ls.builtins.diagnostics

local code_action = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local sources = {
  formatting.gofmt, formatting.lua_format.with({
    extra_args = {
      '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
      '--break-after-table-lb', '--indent-width=2', '--extra-sep-at-table-end',
      '--double-quote-to-single-quote', '--spaces-inside-table-braces',
    },
  }), formatting.black, diag.flake8, formatting.cmake_format,
}

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    lsp_utils.get_null_ls_sources()
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_utils.filtered_formatters(bufnr)
        end,
      })
    end
  end,
})
