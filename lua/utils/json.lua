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

M.GetJqPathAtCursor = function()
  -- 1. Get the current node at cursor
  local node = vim.treesitter.get_node()

  if not node then
    vim.notify("Not on a Tree-sitter node.", vim.log.levels.ERROR)
    return
  end

  local path = {}
  local current = node

  -- 2. Traverse up the tree to the root
  while current do
    local parent = current:parent()
    if not parent then
      break
    end

    local parent_type = parent:type()

    -- Case: Parent is a "pair" ("key": value)
    -- Both the key and the value share this parent.
    -- We always want the text of the key (child 0).
    if parent_type == "pair" then
      local key_node = parent:child(0)
      if key_node then
        local key_text = vim.treesitter.get_node_text(key_node, 0)
        -- Clean up quotes: '"foo"' -> 'foo'
        -- vim.json.decode handles escapes safely
        local ok, decoded = pcall(vim.json.decode, key_text)
        if not ok then
          decoded = key_text:gsub('^"(.*)"$', "%1")
        end
        table.insert(path, { type = "key", name = decoded })
      end

    -- Case: Parent is an "array" ([item1, item2])
    -- We need to find our numeric index.
    elseif parent_type == "array" then
      local index = 0
      -- Iterate over named children only (skipping brackets/commas)
      for child in parent:iter_children() do
        if child:named() then
          if child:id() == current:id() then
            break
          end
          index = index + 1
        end
      end
      table.insert(path, { type = "index", value = index })
    end

    -- Move up
    current = parent
  end

  -- 3. Construct the JQ query string
  -- The path was built bottom-up, so we traverse it in reverse.
  local query = "."
  for i = #path, 1, -1 do
    local part = path[i]
    if part.type == "key" then
      -- Use dot notation for simple keys, bracket for complex ones
      if part.name:match("^[a-zA-Z_][a-zA-Z0-9_]*$") then
        if query == "." then
          query = query .. part.name
        else
          query = query .. "." .. part.name
        end
      else
        query = query .. '["' .. part.name .. '"]'
      end
    elseif part.type == "index" then
      query = query .. "[" .. part.value .. "]"
    end
  end

  return query
end

return M
