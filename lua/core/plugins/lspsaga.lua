return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",

  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
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
