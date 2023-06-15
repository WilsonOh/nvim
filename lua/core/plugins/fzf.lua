return {
  "ibhagwan/fzf-lua",
  config = function()
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
      "max-perf",
      winopts = {
        fullscreen = true,
        preview = {
          horizontal = "right:50%", -- right|left:size
        },
      },
      previewers = {
        bat = {
          args = "--style=numbers,changes,header --color always",
        },
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!package-lock.json' -g '!yarn.lock'",
        -- .. vim.lsp.buf.list_workspace_folders()[1],
      },
    })
  end,
}
