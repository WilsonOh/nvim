return {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = false,
  enabled = true,
  config = function()
    require("treesitter-context").setup({
      enable = true,
      multiline_threshold = 1
    })
  end
}
