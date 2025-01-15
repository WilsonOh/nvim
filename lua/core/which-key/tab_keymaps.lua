local M = {}

M.meta = {
  group = "Tab",
  prefix = "t",
}

M.mappings = {
  { "a", ":$tabnew<CR>", "New Tab" },
  { "c", ":tabclose<CR>", "Close Tab" },
  { "o", ":tabonly<CR>", "Close All Other Tabs" },
  { "n", ":tabn<CR>", "Next Tab" },
  { "p", ":tabp<CR>", "Previous Tab" },
  { "mp", ":-tabmove<CR>", "Move Tab Backwards" },
  { "mn", ":+tabmove<CR>", "Move Tab Forwards" },
  {
    "l",
    function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
      return lazygit:toggle()
    end,
    "LazyGit",
  },
}

return M
