local M = {}

M.meta = {
  group = "Harpoon",
  prefix = "h",
}

M.mappings = {
  {
    "m",
    function()
      require("harpoon.mark").add_file()
    end,
    "Add Mark",
  },
  {
    "M",
    function()
      require("harpoon.ui").toggle_quick_menu()
    end,
    "Toggle Quick Menu",
  },
  {
    "n",
    function()
      require("harpoon.ui").nav_next()
    end,
    "Go To Next Mark",
  },
  {
    "p",
    function()
      require("harpoon.ui").nav_prev()
    end,
    "Go To Previous Mark",
  },
}

for i = 1, 4 do
  table.insert(M.mappings, {
    i,
    function()
      require("harpoon.ui").nav_file(i)
    end,
    string.format("Go to Mark %d", i),
  })
end

return M
