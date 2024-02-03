local M = {
  "akinsho/nvim-toggleterm.lua",
  keys = { [[<C-\>]] },
}

--[[ M.init = function()
  local toggleterm_spawn = vim.api.nvim_create_augroup("toggleterm_spawn", {})
  vim.api.nvim_create_autocmd("VimEnter", {
    group = toggleterm_spawn,
    pattern = "*",
    callback = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local term = Terminal:new()
      term:spawn()
    end,
  })
end ]]

M.config = function()
  local toggleterm_height = math.ceil(vim.api.nvim_win_get_height(0) * 0.45)

  require("toggleterm").setup({
    size = toggleterm_height,
    open_mapping = [[<C-\>]],
    shade_terminals = true,
    shading_factor = "1",
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    autochdir = true,
  })
end

return M
