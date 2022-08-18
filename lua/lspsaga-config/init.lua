require("lspsaga").init_lsp_saga({ code_action_lightbulb = { enable = false } })
local action = require("lspsaga.action")
vim.keymap.set("n", "<C-p>", function()
  action.smart_scroll_with_saga(1)
end, { silent = true })
vim.keymap.set("n", "<C-l>", function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })

-- Example:
local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar"):get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local path_list = vim.split(vim.fn.expand("%:~:.:h"), sep)
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar()
  local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
  local sym
  if ok then
    sym = lspsaga.get_symbol_node()
  end
  local win_val = ""
  win_val = get_file_name(true) -- set to true to include path
  if sym ~= nil then
    win_val = win_val .. "%=" .. sym
  end
  vim.wo.winbar = win_val
end

local events = {
  "CursorHold",
  "BufEnter",
  "BufWinEnter",
  "CursorMoved",
  "WinLeave",
  "User LspasgaUpdateSymbol",
}

local exclude = {
  ["teminal"] = true,
  ["prompt"] = true,
  ["NvimTree"] = true,
  ["toggleterm"] = true,
  ["fish"] = true,
}

vim.api.nvim_create_autocmd(events, {
  pattern = "*",
  callback = function()
    -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
      vim.wo.winbar = ""
    else
      config_winbar()
    end
  end,
})
