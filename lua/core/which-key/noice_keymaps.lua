local M = {}

M.meta = {
  group = "Noice",
  prefix = "n",
}

M.mappings = {
  {
    "l",
    function()
      require("noice").cmd("last")
    end,
    "Noice Last Message",
  },
  {
    "h",
    function()
      require("noice").cmd("history")
    end,
    "Noice History",
  },
  {
    "a",
    function()
      require("noice").cmd("all")
    end,
    "Noice All",
  },
}

return M
