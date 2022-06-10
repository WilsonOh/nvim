if Vapour.plugins.lsp.enabled then
  local lsp_installer = Vapour.utils.plugins.require('nvim-lsp-installer')
  if not lsp_installer then return end
  lsp_installer.on_server_ready(function(server)
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
      .make_client_capabilities())
    local on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor'
          }
          --[[ local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
          local diag = vim.diagnostic.get(bufnr, { lnum = lnum })
          if vim.tbl_isempty(diag) then
            vim.lsp.buf.hover()
          else ]]
          vim.diagnostic.open_float(nil, opts)
          -- end
        end
      })
    end
    local opts = { capabilities = capabilities, on_attach = on_attach }
    if Vapour.language_servers[server.name] then
      opts = Vapour.language_servers[server.name].config(opts)
    end
    server:setup(opts)
  end)
end

local border = {
  { "╭", "FloatBorder" }, { "─", "FloatBorder" }, { "╮", "FloatBorder" }, { "│", "FloatBorder" },
  { "╯", "FloatBorder" }, { "─", "FloatBorder" }, { "╰", "FloatBorder" }, { "│", "FloatBorder" }
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Diagnostics

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Show icons in autocomplete
require('vim.lsp.protocol').CompletionItemKind = {
  '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ',
  '﬌ ', ' ', ' ', '', ' ', ' ', ' ', ' ', '', '', '<>'
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = { spacing = 5, severity_limit = 'Warning' },
  update_in_insert = true
})
