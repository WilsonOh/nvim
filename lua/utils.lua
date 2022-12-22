local M = {}

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

M.run_file = function(from_clipboard, no_input)
  local filename = vim.fn.expand("%:r")
  local filetype = vim.bo.filetype
  local cmd = ""
  local clean_up = ""
  if filetype == "cpp" or filetype == "c" then
    if file_exists("CMakeLists.txt") then
      if file_exists("conanfile.txt") then
        cmd = string.format("cmake --build build && build/bin/%s", filename)
      else
        cmd = string.format("cmake --build build && build/%s", filename)
      end
    else
      cmd = string.format("make %s && ./%s", filename, filename)
    end
    clean_up = string.format("!rm %s", filename)
  elseif filetype == "python" then
    cmd = string.format("python %s.py", filename)
  elseif filetype == "rust" then
    cmd = "cargo run"
  elseif filetype == "java" then
    cmd = string.format("javac %s.java && java %s", filename, filename, filename)
    clean_up = "!rm *.class"
  elseif filetype == "zig" then
    cmd = "zig build run"
  else
    return
  end
  if not no_input then
    if from_clipboard then
      local reg = vim.fn.getreg("*")
      local tmpname = os.tmpname()
      local tmp = io.open(tmpname, "w")
      if tmp then
        tmp:write(reg)
        cmd = cmd .. string.format(" < %s", tmpname)
        tmp:close()
        clean_up = clean_up .. string.format(" && rm %s", tmpname)
      end
    elseif file_exists("input.txt") then
      cmd = cmd .. " < input.txt"
    else
      return
    end
  end
  vim.cmd(":w")
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({
    direction = "float",
    cmd = cmd,
    close_on_exit = false,
    on_exit = function(_)
      vim.cmd("silent " .. clean_up)
    end,
    float_opts = {
      border = "single",
    },
  }):toggle()
end

local enable_transparent_mode = function()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_groups = {
        "Normal",
        "SignColumn",
        "NormalNC",
        "TelescopeBorder",
        "NvimTreeNormal",
        "EndOfBuffer",
        "MsgArea",
      }
      print("activated")
      for _, name in ipairs(hl_groups) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
  vim.opt.fillchars = "eob: "
end

_G.P = function(s)
  vim.pretty_print(s)
end

M.set_colorscheme = function(colorscheme, transparent_bg)
  --[[ require("lazy").load({
    plugins = { colorscheme },
  }) ]]
  pcall(require, "colorschemes." .. colorscheme)
  vim.cmd.colorscheme(colorscheme)

  if transparent_bg then
    enable_transparent_mode()
  end
end

M.get_char_at_cursor = function()
  return vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 1), 0, 1)
end

M.get_word_under_cursor = function()
  local curr_reg = vim.fn.getreg("a")
  vim.api.nvim_cmd({ cmd = "normal!", args = { [["ayiw]] } }, {})
  local word = vim.fn.getreg("a")
  vim.fn.setreg("a", curr_reg)
  return word
end

return M
