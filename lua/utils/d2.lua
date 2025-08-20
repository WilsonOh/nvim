local function setd2ReadonlyOptions(bufnr)
  vim.api.nvim_set_option_value("modifiable", false, {
    scope = "local",
    buf = bufnr,
  })

  vim.api.nvim_set_option_value("readonly", true, {
    scope = "local",
    buf = bufnr,
  })
end

local function unsetd2ReadonlyOptions(bufnr)
  vim.api.nvim_set_option_value("modifiable", true, {
    scope = "local",
    buf = bufnr,
  })

  vim.api.nvim_set_option_value("readonly", false, {
    scope = "local",
    buf = bufnr,
  })
end

local function renderD2(orig_bufnr, d2bufnr)
  local Job = require("plenary.job")
  local output = {}
  local error = {}
  Job:new({
    command = "d2",
    args = { "--ascii-mode=extended", "--stdout-format=ascii", "-", "-" },
    on_stdout = function(_, data)
      table.insert(output, data)
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.schedule(function()
          unsetd2ReadonlyOptions(d2bufnr)
          vim.api.nvim_buf_set_lines(d2bufnr, 0, -1, true, error)
          setd2ReadonlyOptions(d2bufnr)
        end)
        return
      end
      vim.schedule(function()
        unsetd2ReadonlyOptions(d2bufnr)
        vim.api.nvim_buf_set_lines(d2bufnr, 0, -1, true, output)
        setd2ReadonlyOptions(d2bufnr)
      end)
    end,
    writer = vim.api.nvim_buf_get_lines(orig_bufnr, 0, -1, false),
    on_stderr = function(_, data)
      table.insert(error, data)
    end,
  }):start()
end

local d2bufnr = nil
local d2winid = nil
local d2_aucmd_id = nil

vim.api.nvim_create_user_command("D2Start", function()
  local original_bufnr = vim.api.nvim_get_current_buf()
  if d2bufnr == nil then
    d2bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_set_option_value("buftype", "nofile", {
      scope = "local",
      buf = d2bufnr,
    })

    vim.api.nvim_set_option_value("bufhidden", "wipe", {
      scope = "local",
      buf = d2bufnr,
    })
  end
  vim.api.nvim_buf_set_name(d2bufnr, "d2 render")

  local original_win_id = vim.api.nvim_get_current_win()
  vim.cmd("vsplit")
  if d2winid == nil then
    d2winid = vim.api.nvim_get_current_win()
  end
  vim.api.nvim_win_set_buf(d2winid, d2bufnr)
  vim.api.nvim_set_current_win(original_win_id)

  renderD2(original_bufnr, d2bufnr)
  d2_aucmd_id = vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    callback = function()
      renderD2(original_bufnr, d2bufnr)
    end,
    buffer = original_bufnr,
    group = vim.api.nvim_create_augroup("D2 rendering", { clear = true }),
  })
end, {})

vim.api.nvim_create_user_command("D2Stop", function()
  --[[ if d2winid ~= nil then
    vim.api.nvim_win_close(d2winid, false)
  end ]]
  if d2bufnr ~= nil then
    vim.api.nvim_buf_delete(d2bufnr, {})
  end
  d2bufnr = nil
  d2winid = nil
  if d2_aucmd_id ~= nil then
    vim.api.nvim_del_autocmd(d2_aucmd_id)
  end
end, {})
