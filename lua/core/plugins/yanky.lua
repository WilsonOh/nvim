return {
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup({
      highlight = {
        timer = 300,
      },
    })

    -- vim.keymap.set({ "n", "x" }, "Y", "<Plug>(YankyYank)")

    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  end,
  event = "BufReadPost",
}
