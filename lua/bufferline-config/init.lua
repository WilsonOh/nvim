local bufferline = Vapour.utils.plugins.require('bufferline')
bufferline.setup {
  options = {
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    separator_style = "thick",
    --[[ diagnostics = "nvim_lsp",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
            or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end, ]]
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}
