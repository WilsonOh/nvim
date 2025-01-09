local M = {}
function M.real_col()
  local api = vim.api
  local windows = api.nvim_list_wins()
  local buffers = {}
  local col = 0
  for _, win_id in ipairs(windows) do
    local buf_id = api.nvim_win_get_buf(win_id)
    if vim.bo[buf_id].filetype == "NvimTree" then
      local w = api.nvim_win_get_width(win_id)
      col = col + w + 1
      goto continue
    end
    local file_path = api.nvim_buf_get_name(buf_id)

    if file_path ~= "" and vim.loop.fs_stat(file_path) then
      local textoff = vim.fn.getwininfo(win_id)[1].textoff
      local left_col = api.nvim_win_call(win_id, function()
        return vim.fn.winsaveview().leftcol
      end)
      buffers[#buffers + 1] = {
        textoff = textoff,
        win_id = win_id,
        width = api.nvim_win_get_width(win_id),
        position = api.nvim_win_get_position(win_id),
        left_col = left_col,
      }
    end
    ::continue::
  end
  local row = api.nvim_win_get_cursor(0)[1]
  local cursor = api.nvim_win_get_cursor(0)[2] + 1
  -- Currently only go uses tab
  local has_tab = vim.bo.filetype == "go" and string.find(api.nvim_get_current_line(), "\t", nil, true)
  if #buffers == 1 then
    if has_tab then
      col = col + cursor + buffers[1].textoff - buffers[1].left_col + vim.fn.indent(row) * (3 / 4)
    else
      col = col + cursor + buffers[1].textoff - buffers[1].left_col
    end
  elseif #buffers == 2 then
    local f1 = buffers[1]
    local f2 = buffers[2]
    local cur = f1.win_id == api.nvim_get_current_win() and f1 or f2
    local other = cur == 1 and f2 or f1
    if cur.position[2] > other.position[2] then
      if has_tab then
        col = col + other.width + cursor + cur.textoff - cur.left_col + 1 + vim.fn.indent(row) * (3 / 4)
      else
        -- window width contains textoff
        col = col + other.width + cursor + cur.textoff - cur.left_col + 1
      end
    else
      if has_tab then
        col = col + cursor + cur.textoff - cur.left_col + vim.fn.indent(row) * (3 / 4)
      else
        col = col + cursor + cur.textoff - cur.left_col
      end
    end
  end

  return col
end

return M
