local M = {}

M.meta = {
  group = "Json",
  prefix = "j",
}

local json_utils = require("utils.json")

M.mappings = {
  { "v", json_utils.SelectJsonValue, "Format and display JSON string selection " },
  { "p", "<cmd>JqPlaygroundToggle<cr>", "Toggle Jq Playground" },
}

return M
