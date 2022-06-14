local null_ls = Vapour.utils.plugins.require('null-ls')

if not null_ls then return end

local formatting = null_ls.builtins.formatting

local diag = null_ls.builtins.diagnostics

local code_action = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting_sources = {
  formatting.prettier, formatting.gofmt, formatting.lua_format.with({
    extra_args = {
      '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
      '--break-after-table-lb', '--indent-width=2'
    }
  }), formatting.black, formatting.eslint_d
}

local diagnostic_sources = { --[[  diag.codespell, diag.flake8, diag.eslint_d  ]] }

local code_action_sources = {code_action.eslint_d}

local sources = vim.tbl_extend("force", formatting_sources, diagnostic_sources, code_action_sources)

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          require("lsp_utils").filtered_formatters(bufnr)
        end
      })
    end
  end
})
