return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  enabled = true,
  cmd = "FzfLua",
  config = function()
    local opts = {
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
      actions = {
        files = { true }
      },
      grep = {
        actions = {
          ["ctrl-r"] = { require("fzf-lua").actions.toggle_ignore },
          ["ctrl-h"] = { require("fzf-lua").actions.toggle_hidden }
        }
      }
    }
    require('fzf-lua').setup(opts)
  end
}
