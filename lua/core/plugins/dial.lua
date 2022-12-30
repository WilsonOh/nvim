local M = {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function()
        return require("dial.map").inc_normal()
      end,
      expr = true,
    },
    {
      "<C-x>",
      function()
        return require("dial.map").dec_normal()
      end,
      expr = true,
    },
  },
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
end

return M
