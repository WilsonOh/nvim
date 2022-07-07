local navic = require('nvim-navic')

if Vapour.plugins.lsp.enabled then
  local lsp_installer = Vapour.utils.plugins.require('nvim-lsp-installer')
  if not lsp_installer then return end
  lsp_installer.on_server_ready(function(server)

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                         .make_client_capabilities())
    -- Attach nvim-navic if client supports document symbols
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
      -- Highlight symbol under cursor
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

      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })
    end
    local opts = { capabilities = capabilities, on_attach = on_attach }
    if Vapour.language_servers[server.name] then
      opts = Vapour.language_servers[server.name].config(opts)
    end
    server:setup(opts)
    if server.name == 'rust_analyzer' then
      require('rust-tools').setup({ server = opts })
    elseif server.name == 'clangd' then
      require('clangd_extensions').setup({ server = opts })
    end
  end)
end

local border = {
  { '╭', 'FloatBorder' }, { '─', 'FloatBorder' }, { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' }, { '╯', 'FloatBorder' }, { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' }, { '│', 'FloatBorder' },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Diagnostics

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

vim.diagnostic.config({
  virtual_text = {
    source = 'always', -- Or "if_many"
  },
  float = {
    source = 'always', -- Or "if_many"
  },
})

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- Show icons in autocomplete
require('vim.lsp.protocol').CompletionItemKind = {
  '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ',
  '﬌ ', ' ', ' ', '', ' ', ' ', ' ', ' ', '', '', '<>',
}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = { source = 'always', 'spacing = 5', severity_limit = 'Warning' },
      update_in_insert = true,
    })
