local M = {}

M.meta = {
  group = "Harpoon",
  prefix = "h",
}

local harpoon = require("harpoon")
harpoon:setup()

M.mappings = {
  {
    "m",
    function()
      harpoon:list():add()
    end,
    "Add Mark",
  },
  {
    "M",
    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    "Toggle Quick Menu",
  },
  {
    "n",
    function()
      harpoon:list():next()
    end,
    "Go To Next Mark",
  },
  {
    "p",
    function()
      harpoon:list():prev()
    end,
    "Go To Previous Mark",
  },
}

for i = 1, 4 do
  table.insert(M.mappings, {
    i,
    function()
      harpoon:list():select(i)
    end,
    string.format("Go to Mark %d", i),
  })
end

return M
