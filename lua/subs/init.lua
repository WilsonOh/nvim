local M = {}

local get_word_under_cursor = function()
  local curr_reg = vim.fn.getreg("a")
  vim.api.nvim_cmd({ cmd = "normal!", args = { [["ayiw]] } }, {})
  local word = vim.fn.getreg("a")
  vim.fn.setreg("a", curr_reg)
  return word
end

M.sub = function()
  local word = get_word_under_cursor()
  local cmd = "%s/" .. word .. "/" .. vim.fn.input({ prompt = "Enter the word to substitute: " }) .. "/g"
  vim.cmd(cmd)
end

return M
