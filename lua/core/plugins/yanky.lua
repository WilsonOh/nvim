return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", { "n", "x" } },
  },
  config = function()
    require("yanky").setup({
      highlight = {
        timer = 300,
      },
    })
  end,
}
