local utils = require('nvim-surround.utils')

require('nvim-surround').buffer_setup {
  delimiters = {
    pairs = {
      ['f'] = function()
        return { 'def ' .. utils.get_input('Enter Function Name: ') .. '(', { '):', '' } }
      end,

    },
  },
}
