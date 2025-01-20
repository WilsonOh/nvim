local M = {}

M.custom_search = function()
  Snacks.input.input({ prompt = "Enter the directory: ", completion = "dir" }, function(value)
    Snacks.picker.files({ cwd = value, title = string.format("Searching %s", value) })
  end)
  -- require("telescope.builtin").find_files({ cwd = cwd })
end

M.config_search = function()
  local config_path = vim.fn.stdpath("config")
  --[[ require("fzf-lua").files({
    prompt_title = "Search Config...",
    cwd = config_path,
  }) ]]
  Snacks.picker.files({ cwd = config_path, title = "Search Config..." })
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
  local obj = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }):wait()
  if obj.code ~= 0 then
    vim.notify_once(
      "Unable to do project search, not LSP workspace or git directory detected.\nSearching in CWD instead",
      vim.log.levels.WARN
    )
    fzf.files()
  else
    fzf.git_files()
  end
end

M.search_current_buf_dir = function()
  local buf_path = vim.fn.expand("%:p")
  local buf_dir = vim.fs.dirname(buf_path)
  Snacks.picker.files({ cwd = buf_dir, title = "Search Current Buffer Directory..." })
  --[[ require("fzf-lua").files({
    prompt_title = "Search Current Buffer Directory...",
    cwd = buf_dir,
  }) ]]
end

M.search_plugin_files = function()
  local title = "Search Plugin Files"
  local cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  Snacks.picker.files({ title = title, cwd = cwd })
  --[[ return require("fzf-lua").files({
    prompt_title = "Search Plugin Files",
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
  }) ]]
end

return M
