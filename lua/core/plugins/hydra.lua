local M = {
  "anuvyklack/hydra.nvim",
  enabled = true,
  keys = { "<leader>g" },
}

M.config = function()
  local Hydra = require("hydra")
  local gitsigns = require("gitsigns")

  local hint = [[
^                               Git Mode
^                              ----------
^ _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
^ _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
^ ^ ^              _S_: stage buffer      _r_: reset hunk     _/_: show base file
^ ^
^ ^ ^                           _<Esc>_: exit
]]

  Hydra({
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = { position = "bottom", border = "rounded" },
      on_enter = function()
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
        vim.cmd([[GitBlameEnable]])
      end,
      on_exit = function()
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
        vim.cmd([[GitBlameDisable]])
      end,
    },
    mode = { "n", "x" },
    body = "<leader>g",
    heads = {
      {
        "J",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return "<Ignore>"
        end,
        { expr = true },
      },
      {
        "K",
        function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return "<Ignore>"
        end,
        { expr = true },
      },
      { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
      { "u", gitsigns.undo_stage_hunk },
      { "S", gitsigns.stage_buffer },
      { "p", gitsigns.preview_hunk },
      { "d", gitsigns.toggle_deleted, { nowait = true } },
      { "b", gitsigns.blame_line },
      {
        "r",
        vim.schedule_wrap(function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end),
      },
      {
        "B",
        function()
          gitsigns.blame_line({ full = true })
        end,
      },
      { "/", gitsigns.show, { exit = true } }, -- show the base of the file
      { "<Esc>", nil, { exit = true, nowait = true } },
    },
  })
end

return M
