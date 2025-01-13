return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  enabled = true,
  cmd = "FzfLua",
  opts = {
    "max-perf",
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
