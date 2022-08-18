require("nvim-surround").buffer_setup({
  surrounds = {
    ["i"] = {
      add = function()
        return { { "#include <" }, { ">" } }
      end,
    },
    ["I"] = {
      add = function()
        return { { '#include "' }, { '"' } }
      end,
    },
    ["p"] = {
      add = function()
        return { { "std::cout << " }, { [[ << '\n';]] } }
      end,
    },
  },
})
