local M = {
  "monaqa/dial.nvim",
  lazy = false,
}

M.config = function()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.hexcolor.new({
        case = "lower",
      }),
      augend.constant.new({
        elements = { "and", "or" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "True", "False" },
        word = true,
        cyclic = true,
      }),
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.date.alias["%d/%m/%Y"],
      augend.constant.alias.bool,
      augend.semver.alias.semver,
    },
  })
  vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
  end)
  vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
  end)
end

return M
