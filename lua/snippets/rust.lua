local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local rep = require("luasnip.extras").rep

return {
  s("test", fmt(
    [[
      #[test]
      fn {}(){}{{
          {}
      }}
    ]],
    {
      i(1, "testname"),
      d(2, function ()
        local nodes = {}
        table.insert(nodes, t(""))
        table.insert(nodes, t(" -> Result<Ok(), Error> "))
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for _, line in ipairs(lines) do
          if line:match("anyhow::Result") then
            table.insert(nodes, t(" -> Result<()> "))
          end
        end
        return sn(nil, c(1, nodes))
      end),
      i(0),
    }
  ))
}
