local M = {}

M.meta = {
  group = "Run File",
  prefix = "r",
}

M.mappings = {
  {
    "r",
    function()
      require("utils").run_file(false, true)
    end,
    "Without Input",
  },
  {
    "f",
    function()
      require("utils").run_file()
    end,
    "From File",
  },
  {
    "c",
    function()
      require("utils").run_file(true)
    end,
    "From Clipboard",
  },
}

return M
