require('nvim-surround').buffer_setup({
  delimiters = {
    pairs = {
      ['i'] = function()
        return { '#include <', '>' }
      end,
      ['I'] = function()
        return { '#include "', '"' }
      end,
      ['p'] = function()
        return { 'std::cout << ', [[ << '\n';]] }
      end,
    },
  },
})
