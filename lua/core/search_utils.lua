local M = {}

M.custom_search = function()
  local cwd = vim.fn.input("Enter the directory: ")
  require("telescope.builtin").find_files({ cwd = cwd })
end

M.config_search = function()
  local config_path = vim.fn.stdpath("config")
  require("fzf-lua").files({
    prompt_title = "Search Config...",
    cwd = config_path,
  })
end

function M.project_search(opts)
  local default_config = {
    prompt_title = "Search Project...",
    prompt = "Search Project...",
    show_untracked = true,
  }
  local fzf = require("fzf-lua")
  opts = vim.tbl_deep_extend("force", opts or {}, default_config)
  local client = vim.lsp.get_clients()[1]
  if client then
    opts.cwd = client.config.root_dir
    return fzf.files(opts)
  end
  local ok, _ = pcall(fzf.git_files, opts)
  if not ok then
    vim.notify_once(
      "Unable to do project search, not LSP workspace or git directory detected.\nSearching in CWD instead",
      vim.log.levels.WARN
    )
    return fzf.files()
  end
end

M.search_current_buf_dir = function()
  local buf_path = vim.fn.expand("%:p")
  local buf_dir = vim.fs.dirname(buf_path)
  require("fzf-lua").files({
    prompt_title = "Search Current Buffer Directory...",
    cwd = buf_dir,
  })
end

M.search_plugin_files = function()
  return require("fzf-lua").files({
    prompt_title = "Search Plugin Files",
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
  })
end

return M
