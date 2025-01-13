return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "TelescopePrompt",
        "NvimTree",
      },
    })
  end,
}
