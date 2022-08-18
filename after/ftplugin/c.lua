require("nvim-surround").buffer_setup({
  surrounds = {
    ["i"] = {
      add = function()
        return { { "#include <" }, { ".h>" } }
      end,
    },
    ["I"] = {
      add = function()
        return { { '#include "' }, { '.h"' } }
      end,
    },
    ["p"] = {
      add = function()
        local input = require("nvim-surround.config").get_input("Format specifier: ")
        local types = vim.split(input, " ")
        local res = ""
        if #types >= 0 then
          for idx, type in ipairs(types) do
            res = res .. "%" .. type
            if idx < #types then
              res = res .. " "
            end
          end
          return { { 'printf("' .. res .. '", ' }, { ");" } }
        end
      end,
    },
  },
})
