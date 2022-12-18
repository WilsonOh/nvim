require("nvim-surround").buffer_setup({
  surrounds = {
    ["s"] = {
      add = function()
        return { { "<" }, { " />" } }
      end,
    },
  },
})
