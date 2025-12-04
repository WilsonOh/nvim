local M = {}

M.gotoGitlab = function()
  local winid = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(winid))
  local remote_url_args = { "remote", "get-url", "origin" }

  local Job = require("plenary.job")

  local res = {}
  local error_lines = {}

  Job:new({
    command = "git",
    on_stdout = function(_, data)
      table.insert(res, data)
    end,
    on_stderr = function(_, data)
      table.insert(error_lines, data)
    end,
    args = remote_url_args,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code ~= 0 then
          local error_msg = table.concat(error_lines, "\n")
          vim.notify(error_msg)
          return
        end
        local remote_url = table.concat(res, "")
        local project_url = remote_url:gsub("^.-@(.+):(.+)%.git$", "https://%1/%2")
        local tree_url = string.format("%s/-/blob/master", project_url)
        local file_url = string.format("%s/%s", tree_url, vim.fn.expand("%r"))
        local file_url_with_line_num = string.format("%s#L%d", file_url, row)
        vim.ui.open(file_url_with_line_num)
      end)
    end,
  }):start()
end

return M
