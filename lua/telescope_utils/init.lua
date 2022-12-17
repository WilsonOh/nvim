local M = {}

M.custom_search = function()
  local cwd = vim.fn.input("Enter the directory: ")
  require("telescope.builtin").find_files({ cwd = cwd })
end

M.config_search = function()
  local config_path = vim.fn.stdpath("config")
  require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
    cwd = config_path,
  }))
end

M.project_search = function()
  local clients = vim.lsp.get_active_clients()
  local root_dir = ""
  for _, client in ipairs(clients) do
    if client.config.root_dir ~= nil then
      root_dir = client.config.root_dir
      break
    end
  end
  require("telescope.builtin").find_files({ cwd = root_dir })
end

return M
