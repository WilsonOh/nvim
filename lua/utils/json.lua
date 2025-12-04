local M = {}

M.SelectJsonValue = function()
  -- 1. Get the current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- Tree-sitter uses 0-indexed rows and columns
  local ts_row = row - 1

  -- 2. Find the deepest node at the current cursor position
  -- We use "json" as the parser name.
  local node = vim.treesitter.get_node({
    row = ts_row,
    col = col,
    language = "json",
  })

  if not node then
    print("Not on a Tree-sitter node.")
    return
  end

  -- 3. Traverse up to find the "pair" node that contains the key/value
  local pair_node = nil
  local current_node = node

  -- Go up until we hit a 'pair' node or the root
  while current_node and current_node:type() ~= "pair" do
    -- If the cursor is on the key string, this path is often required.
    -- For JSON, the key is usually a 'string' node, which is a child of 'pair'.
    current_node = current_node:parent()
  end

  pair_node = current_node

  if not pair_node then
    print("Could not find a 'pair' node.")
    return
  end

  -- 4. Find the 'value' child of the 'pair' node
  -- In a JSON 'pair', the children are usually:
  --   0. 'string' (the key)
  --   1. ':'
  --   2. the actual value (e.g., 'array', 'string', 'object', etc.)
  local value_node = pair_node:child(2)

  if not value_node then
    print("Could not find the value node within the pair.")
    return
  end

  local value_node_text = vim.treesitter.get_node_text(value_node, 0)
  local Job = require("plenary.job")
  local cmd = "jq"
  local res = {}
  local error_lines = {}

  Job:new({
    command = cmd,
    on_stdout = function(_, data)
      table.insert(res, data)
    end,
    on_stderr = function(_, data)
      table.insert(error_lines, data)
    end,
    args = { ". | fromjson" },
    writer = value_node_text,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code ~= 0 then
          local error_msg = table.concat(error_lines, "\n")
          vim.notify(error_msg)
          return
        end
        local bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, res)
        vim.api.nvim_open_win(bufnr, true, { split = "right" })
        vim.bo[bufnr].filetype = "json"
      end)
    end,
  }):start()
end

return M
