return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",

  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        respect_root = true,
      },
    })
  end,
}
