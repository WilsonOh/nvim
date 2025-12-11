local M = {}

M.meta = {
  group = "Json",
  prefix = "j",
}

local json_utils = require("utils.json")

M.mappings = {
  { "v", json_utils.SelectJsonValue, "Format and display JSON string selection " },
  { "p", "<cmd>JqPlaygroundToggle<cr>", "Toggle Jq Playground" },
  {
    "s",
    function()
      local path = json_utils.GetJqPathAtCursor()
      require("jq-playground.playground").set_and_run_jq_query_input(path)
    end,
    "Toggle Jq Playground",
  },
}

return M
