local M = {}

M.custom_search = function()
	local cwd = vim.fn.input("Enter the directory: ")
	local search_dir = vim.fn.input("Enter the search directory: ")
	require("telescope.builtin").find_files({ cwd = cwd, search_dir = search_dir })
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
