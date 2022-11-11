require("catppuccin").setup({
  flavour = "macchiato",
  dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
  transparent_background = false,
  term_colors = true,
  compile = { enabled = true, path = vim.fn.stdpath("cache") .. "/catppuccin", suffix = "_compiled" },
  integrations = {
    native_lsp = {
      virtual_text = {
        errors = { "bold" },
        hints = { "bold" },
        warnings = { "bold" },
        information = { "bold" },
      },
    },
  },
})
