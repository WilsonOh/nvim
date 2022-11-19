require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

require("nvim-surround").buffer_setup({
  surrounds = {
    ["f"] = {
      add = function()
        return {
          { "def " .. require("nvim-surround.config").get_input("Enter Function Name: ") .. "(" },
          { "):", "" },
        }
      end,
    },
  },
})
