return {
  {
    "WilsonOh/blame.nvim",
    cmd = { "BlameToggle" },
    config = function()
      require("blame").setup({
        focus_blame = true,
      })
    end,
  },
}
