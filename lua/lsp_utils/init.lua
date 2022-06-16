local null_ls = require('null-ls')

local M = {}

M.get_null_ls_sources = function()
  local filetype = vim.bo.filetype
  local null_ls_sources = null_ls.get_sources()
  local ret = {}
  for _, source in ipairs(null_ls_sources) do
    if source.filetypes[filetype] then table.insert(ret, source.name) end
  end
  return ret
end

M.filtered_formatters = function(bufnr)
  local clients = vim.lsp.buf_get_clients()
  local formatting_clients = {}
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/formatting') then
      table.insert(formatting_clients, client)
    end
  end
  if #formatting_clients == 0 then
    vim.notify('[LSP] There are no LSPs attached with formatting capabilities')
    return
  end
  local null_ls_formatter = vim.tbl_filter(function(client)
    return client.name == 'null-ls'
  end, formatting_clients)
  if #null_ls_formatter ~= 0 then
    vim.lsp.buf.format({ bufnr = bufnr, name = 'null-ls' })
    vim.notify(string.format('%d lines formatted with %s.', vim.api.nvim_buf_line_count(0),
                             'null-ls'))
    return
  end
  for _, client in ipairs(formatting_clients) do
    vim.lsp.buf.format({ bufnr = bufnr, name = client.name })
    vim.notify(string.format('%d lines formatted with %s.', vim.api.nvim_buf_line_count(0),
                             client.name))
  end
end

M.filtered_range_formatters = function(bufnr)
  local clients = vim.lsp.buf_get_clients()
  local formatting_clients = {}
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/rangeFormatting') then
      table.insert(formatting_clients, client)
    end
  end
  local start = vim.fn.getpos('v')[2]
  local stop = vim.fn.getcurpos()[2]
  if #formatting_clients == 0 then
    vim.notify('[LSP] There are no LSPs attached with range formatting capabilities')
    return
  end
  local null_ls_formatter = vim.tbl_filter(function(client)
    return client.name == 'null-ls'
  end, formatting_clients)
  if #null_ls_formatter ~= 0 then
    vim.lsp.buf.range_formatting({ bufnr = bufnr, name = 'null-ls' })
    vim.notify(string.format('%d lines range formatted with %s.', math.abs(stop - start) + 1,
                             'null-ls'))
    return
  end
  for _, client in ipairs(formatting_clients) do
    vim.lsp.buf.range_formatting({ bufnr = bufnr, name = client.name })
    vim.notify(string.format('%d lines range formatted with %s.', math.abs(stop - start) + 1,
                             client.name))
  end
end

return M
