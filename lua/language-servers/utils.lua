local null_ls = require('null-ls')

local M = {}

M.hover_function_on_hold = function(_, bufnr)

  vim.api.nvim_create_augroup('lsp_hover', { clear = true })
  vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_hover' })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lsp_hover',
    buffer = bufnr,
    callback = function()
      local ts_utils = require('nvim-treesitter.ts_utils')
      local cur_node = ts_utils.get_node_at_cursor()
      if not cur_node or (cur_node:type() ~= 'identifier') then return end
      while (cur_node and cur_node:type() ~= 'function_call') do cur_node = cur_node:parent() end
      if not cur_node then return end
      vim.lsp.buf.hover()
    end,
  })
end

M.get_null_ls_sources = function()
  local filetype = vim.bo.filetype
  local null_ls_sources = null_ls.get_sources()
  local ret = {}
  for _, source in ipairs(null_ls_sources) do
    if source.filetypes[filetype] then table.insert(ret, source) end
  end
  return ret
end

M.get_null_ls_source_by_method = function(method)
  local sources = M.get_null_ls_sources()
  local method_filter = null_ls.methods[method]
  for _, source in pairs(sources) do if source.methods[method_filter] then return source.name end end
  vim.notify('There\'s no null-ls source for the method: ' .. method)
  return 'NONE'
end

--[[ local navic = require('nvim-navic')

M.get_navic = function()
  if navic.is_available() then
    return '%=' .. navic.get_location()
  else
    return ''
  end
end ]]

M.filtered_formatters = function(bufnr)
  local clients = vim.lsp.get_active_clients()
  local formatting_clients = {}
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/formatting')
        or client.server_capabilities.documentFormattingProvider then
      table.insert(formatting_clients, client)
    end
  end
  if #formatting_clients == 0 then
    vim.notify('[LSP] There are no LSPs attached with formatting capabilities')
    return
  end
  local null_ls_formatter = vim.tbl_filter(function(client)
    local null_ls_sources = M.get_null_ls_sources()
    return client.name == 'null-ls' and #null_ls_sources ~= 0
  end, formatting_clients)
  if #null_ls_formatter ~= 0 then
    vim.lsp.buf.format({ bufnr = bufnr, name = 'null-ls' })
    vim.notify(string.format('%d lines formatted with %s.', vim.api.nvim_buf_line_count(0),
                             M.get_null_ls_source_by_method('FORMATTING')))
    return
  end
  for _, client in ipairs(formatting_clients) do
    if client.name ~= 'null-ls' then
      vim.lsp.buf.format({ bufnr = bufnr, name = client.name })
      vim.notify(string.format('%d lines formatted with %s.', vim.api.nvim_buf_line_count(0),
                               client.name))
      return
    end
  end
  vim.notify('[LSP] There are no LSPs attached with formatting capabilities')
end

M.filtered_range_formatters = function(bufnr)
  local clients = vim.lsp.get_active_clients()
  local formatting_clients = {}
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/rangeFormatting')
        or client.server_capabilities.documentRangeFormattingProvider then
      table.insert(formatting_clients, client)
    end
  end
  local start = vim.list_slice(vim.fn.getpos('v'), 1, 2)
  local stop = vim.list_slice(vim.fn.getcurpos(), 1, 2)
  local start_row = start[2]
  local stop_row = stop[2]
  if #formatting_clients == 0 then
    vim.notify('[LSP] There are no LSPs attached with range formatting capabilities')
    return
  end
  local null_ls_formatter = vim.tbl_filter(function(client)
    local null_ls_sources = M.get_null_ls_sources()
    return client.name == 'null-ls' and #null_ls_sources ~= 0
  end, formatting_clients)
  if #null_ls_formatter ~= 0 then
    vim.lsp.buf.range_formatting({ bufnr = bufnr, name = 'null-ls' })
    vim.notify(string.format('%d lines range formatted with %s.',
                             math.abs(stop_row - start_row) + 1,
                             M.get_null_ls_source_by_method('FORMATTING')))
    return
  end
  for _, client in ipairs(formatting_clients) do
    if client.name ~= 'null-ls' then
      vim.lsp.buf.range_formatting({ bufnr = bufnr, name = client.name })
      vim.notify(string.format('%d lines range formatted with %s.',
                               math.abs(stop_row - start_row) + 1, client.name))
      return
    end
  end
  vim.notify('[LSP] There are no LSPs attached with range formatting capabilities')
end

return M
