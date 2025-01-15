return {
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "<leader>s",
        normal_cur = "<leader>ss",
      },
      move_cursor = false,
    })
  end,
  lazy = false,
}
