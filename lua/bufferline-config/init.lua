local bufferline = Vapour.utils.plugins.require('bufferline')
bufferline.setup {
  options = {
    close_command = 'Bdelete! %d',
    right_mouse_command = 'Bdelete! %d',
    separator_style = 'slant',
    diagnostics = 'nvim_lsp',
    numbers = 'ordinal',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'center',
      },
    },
  },
}
