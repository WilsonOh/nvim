return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  main = "ibl",
  opts = {
    --[[ scope = {
      show_start = false,
    }, ]]
    indent = {
      char = "│",
      tab_char = "│",
    },
    exclude = {
      filetypes = { "alpha", "lazy", "NvimTree", "mason", "help", "DiffviewPanel", "Neogit*" },
      buftypes = { "terminal" },
    },
  },
}
