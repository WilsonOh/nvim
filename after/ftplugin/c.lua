require('nvim-surround').buffer_setup({
  delimiters = {
    pairs = {
      ['i'] = function()
        return { '#include <', '.h>' }
      end,
      ['I'] = function()
        return { '#include "', '.h"' }
      end,
      ['p'] = function()
        local input = require('nvim-surround.utils').get_input('Format specifier: ')
        local types = vim.split(input, ' ')
        local res = ''
        if #types >= 0 then
          for idx, type in ipairs(types) do
            res = res .. '%' .. type
            if idx < #types then res = res .. ' ' end
          end
          return { 'printf("' .. res .. '", ', ');' }
        end
      end,
    },
  },
})
