require("nvim-surround").buffer_setup({
  surrounds = {
    ["l"] = {
      add = function()
        return { { "[" }, { "](" .. vim.fn.getreg("*") .. ")" } }
      end,
    },
  },
})
