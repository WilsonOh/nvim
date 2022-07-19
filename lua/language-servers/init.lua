require('nvim-lsp-installer').setup({})

local lspconfig = require('lspconfig')

-- LSPs which take in general settings
local lsps = {
  'clangd', 'cmake', 'cssls', 'denols', 'emmet_ls', 'gopls', 'hls', 'html', 'marksman', 'pyright',
  'rust_analyzer', 'tsserver',
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                     .make_client_capabilities())

local utils = require('language-servers.utils')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  utils.get_null_ls_sources()
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        utils.filtered_formatters(bufnr)
      end,
    })
  end
end

local opts = { capabilities = capabilities, on_attach = on_attach }

for _, lsp in ipairs(lsps) do lspconfig[lsp].setup(opts) end

-- LSPs with special settings
lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } },
  },
})

-- Calling the setup function through language specific plugins
require('rust-tools').setup()
require('clangd_extensions').setup()

require('language-servers.settings')
