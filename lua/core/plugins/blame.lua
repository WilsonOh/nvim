return {
  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    config = function()
      require('blame').setup({
        focus_blame = false,
      })
    end,
  },
}
