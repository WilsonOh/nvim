local M = {}

M.custom_search = function()
  local cwd = vim.fn.input('Enter the directory: ')
  local search_dir = vim.fn.input('Enter the search directory: ')
  require('telescope.builtin').find_files({ cwd = cwd, search_dir = search_dir })
end

return M
