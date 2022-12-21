local M = {}

M.custom_search = function()
	local cwd = vim.fn.input("Enter the directory: ")
	require("telescope.builtin").find_files({ cwd = cwd })
end

M.config_search = function()
	local config_path = vim.fn.stdpath("config")
	require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
		prompt_title = "Search Config...",
		cwd = config_path,
	}))
end

function M.project_search(opts)
	opts = opts or {
		prompt_title = "Seach Project...",
	}
	opts.show_untracked = true
	if vim.loop.fs_stat(".git") then
		require("telescope.builtin").git_files(opts)
	else
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		require("telescope.builtin").find_files(opts)
	end
end

return M
