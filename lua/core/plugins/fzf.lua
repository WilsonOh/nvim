return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  enabled = true,
  cmd = "FzfLua",
  opts = {
    "telescope",
    winopts = {
      fullscreen = true,
      preview = {
        horizontal = "right:50%",
      },
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
  },
}
