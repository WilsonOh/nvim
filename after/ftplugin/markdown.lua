require("nvim-surround").buffer_setup({
  surrounds = {
    ["l"] = {
      add = function()
        return { { "[" }, { "](" .. vim.fn.getreg("*") .. ")" } }
      end,
    },
    ["p"] = {
      add = function()
        return { { "**" }, { "**" } }
      end,
    },
    ["i"] = {
      add = function()
        return { { "_" }, { "_" } }
      end,
    },
  },
})
