return {
  "petertriho/nvim-scrollbar",
  enabled = false,
  config = function()
    local cp = require("catppuccin.palettes").get_palette()
    require("scrollbar").setup({
      handle = {
        color = cp.blue,
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
      },
    })
  end,
  event = "BufReadPost",
}
