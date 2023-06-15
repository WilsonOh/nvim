return {
  "nanozuki/tabby.nvim",
  event = "VeryLazy",
  config = function()
    local palette = require("rose-pine.palette")

    require("tabby.tabline").use_preset("active_wins_at_tail", {
      theme = {
        line = { fg = palette.text, bg = palette.surface },
        head = { fg = palette.surface, bg = palette.iris, style = "italic" },
        current_tab = { fg = palette.surface, bg = palette.rose, style = "bold" },
        tab = { fg = palette.text, bg = palette.overlay, style = "bold" },
        win = { fg = palette.text, bg = palette.overlay },
        tail = { fg = palette.surface, bg = palette.rose, style = "bold" },
      },
      tab_name = {
        name_fallback = function(tabid)
          return ""
        end,
      },
    })
  end,
}
