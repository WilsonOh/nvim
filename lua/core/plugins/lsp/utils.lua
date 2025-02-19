local null_ls = require("null-ls")

local M = {}

M.find_project_root = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local non_null_ls_clients = vim.tbl_filter(function(client)
    return client.name ~= null_ls
  end, clients)
  for _, client in ipairs(non_null_ls_clients) do
    if client.config.root_dir ~= nil then
      return client.config.root_dir
    end
  end
  return nil
end

M.format_json = function(bufnr, compact)
  local curr_buf = bufnr or 0
  local is_compact = compact == nil and false or compact
  local compact_cmd = is_compact and "-c" or ""
  vim.fn.jobstart({ "jq", compact_cmd, ".", vim.fn.expand("%:p") }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(curr_buf, 0, -1, false, data)
        vim.api.nvim_buf_set_lines(curr_buf, -2, -1, false, {})
      end
    end,
  })
end

M.hover_function_on_hold = function(_, bufnr)
  vim.api.nvim_create_augroup("lsp_hover", { clear = true })
  vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_hover" })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "lsp_hover",
    buffer = bufnr,
    callback = function()
      local ts_utils = require("nvim-treesitter.ts_utils")
      local cur_node = ts_utils.get_node_at_cursor()
      if not cur_node or (cur_node:type() ~= "identifier") then
        return
      end
      while cur_node and cur_node:type() ~= "function_call" do
        cur_node = cur_node:parent()
      end
      if not cur_node then
        return
      end
      vim.lsp.buf.hover()
    end,
  })
end

M.get_null_ls_sources = function()
  local filetype = vim.bo.filetype
  local null_ls_sources = null_ls.get_sources()
  local ret = {}
  for _, source in ipairs(null_ls_sources) do
    if source.filetypes[filetype] then
      table.insert(ret, source)
    end
  end
  return ret
end

M.get_null_ls_source_by_method = function(method)
  local sources = M.get_null_ls_sources()
  local method_filter = null_ls.methods[method]
  for _, source in pairs(sources) do
    if source.methods[method_filter] then
      return source.name
    end
  end
  vim.notify("There's no null-ls source for the method: " .. method, vim.log.levels.WARN)
end

M.format = function(bufnr)
  bufnr = bufnr or 0
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local other_formatting_clients = {}

  local filetype = vim.bo.filetype
  local n = require("null-ls")
  local s = require("null-ls.sources")
  local method = n.methods.FORMATTING
  local null_ls_formatting_clients = s.get_available(filetype, method)

  for _, client in ipairs(clients) do
    if client.server_capabilities.documentFormattingProvider then
      if client.name ~= "null-ls" then
        table.insert(other_formatting_clients, client)
      end
    end
  end
  if #null_ls_formatting_clients == 0 and #other_formatting_clients == 0 then
    vim.notify("[LSP] There are no LSPs attached with formatting capabilities", vim.log.levels.WARN)
    return
  end
  local client_name = ""
  if #null_ls_formatting_clients ~= 0 then
    vim.lsp.buf.format({ bufnr = bufnr, name = "null-ls" })
    client_name = M.get_null_ls_source_by_method("FORMATTING")
  else
    client_name = other_formatting_clients[1].name
    vim.lsp.buf.format({ bufnr = bufnr, name = client_name })
  end
  vim.notify_once(
    string.format("%d lines formatted with %s.", vim.api.nvim_buf_line_count(bufnr), client_name),
    vim.log.levels.INFO
  )
end

return M
