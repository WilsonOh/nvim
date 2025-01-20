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

M.get_swagger_docs_node = function()
  local query = vim.treesitter.query.parse(
    vim.bo.filetype,
    [[
(((comment) @swagger_docs
            (#contains? @swagger_docs "@swagger")) @injection.content
            (#set! injection.language "yaml")
            (#offset! @injection.content 2 3 0 0))
  ]]
  )
  local parser = vim.treesitter.get_parser(0, vim.bo.filetype, {})
  local root = parser:parse()[1]:root()
  for id, node in query:iter_captures(root, 0, 0, -1) do
    local capture_name = query.captures[id]
    if capture_name == "injection.content" then
      local text = vim.treesitter.get_node_text(node, 0)
      vim.print(text)
    end
  end
end

--- @param filename string
--- @return boolean
local function check_file_exists(filename)
  local cwd = vim.uv.cwd()
  return vim.fn.filereadable(cwd .. filename) == 1
end

local function is_cmake_project()
  return check_file_exists("CMakeLists.txt")
end

M.run_cmake_project = function()
  local Job = require("plenary.job")
  local executable_command = ""
  local get_project_name_job = Job:new({
    command = "rg",
    args = { [[project\((.*)\)]], "CMakeLists.txt", "-or", "$1" },
    cwd = vim.uv.cwd(),
    on_stdout = function(_, data, _)
      local tokens = vim.split(data, " ", { trimempty = true })
      local project_name = tokens[1]
      executable_command = "build/" .. project_name
      print(executable_command)
    end,
  })
  local build_job = Job:new({
    command = "cmake",
    args = { "--build", "build" },
  })
  --[[ local execute_job = Job:new({
    command = executable_command,
  }) ]]
  get_project_name_job:and_then(build_job)
  -- build_job:and_then_on_success(execute_job)
  get_project_name_job:start()
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
        clean_up = clean_up .. string.format(" && rm -f %s", tmpname)
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

M.format_json = function()
  local command = "/Users/wilsonoh/json_parser_rs/target/release/json_parser_rs"
  local Job = require("plenary.job")
  local formatted = {}
  Job:new({
    command = command,
    writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
    -- args = { "-c", ".", vim.fn.expand("%:p") },
    on_stdout = function(_, data)
      vim.schedule(function()
        table.insert(formatted, data)
      end)
    end,
    on_exit = function()
      vim.schedule(function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
      end)
    end,
    on_stderr = function()
      vim.print("failed to format json")
    end,
  }):start()
end

return M
