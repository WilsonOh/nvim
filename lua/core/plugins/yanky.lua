return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", { "n", "x", "o", "v" } },
    { "p", "<Plug>(YankyPutAfter)", { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", { "n", "x" } },
    { "gn", "<Plug>(YankyCycleForward)", { "n" } },
    { "gp", "<Plug>(YankyCycleBackward)", { "n" } },
  },
  config = function()
    require("yanky").setup({
      highlight = {
        timer = 300,
      },
    })
    require("telescope").load_extension("yank_history")
  end,
}
