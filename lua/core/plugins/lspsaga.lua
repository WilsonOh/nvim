return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  enabled = false,

  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = true,
        hide_keyword = true,
      },
      finder = {
        keys = {
          vsplit = "v",
          split = "s",
          toggle_or_open = "<CR>",
        },
        default = "ref",
      },
    })
  end,
}
