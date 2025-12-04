local M = {}

M.meta = {
  group = "Files",
  prefix = "g",
}

M.mappings = {
  {
    "d",
    "<cmd>DiffviewOpen<CR>",
    "Open DiffView",
  },
  {
    "c",
    "<cmd>DiffviewClose<CR>",
    "Close DiffView",
  },
  {
    "n",
    "<cmd>Neogit<cr>",
    "Open Neogit",
  },
  {
    "t",
    MiniDiff.toggle_overlay,
    "Toggle diff overlay",
  },
  {
    "b",
    "<cmd>BlameToggle<cr>",
    "Toggle Git Blame Window",
  },
  {
    "o",
    require("utils.git").gotoGitlab,
    "Open Current File in remote GitLab",
  },
}

return M
