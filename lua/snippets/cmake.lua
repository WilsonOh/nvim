local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_cmake_version()
  return io.popen("cmake --version", "r"):read("*l"):gsub("^[%s%a]+", "")
end

local function get_cmake_sources(path)
  local output = vim.trim(io.popen("ls " .. path, "r"):read("*a"))
  local files = vim.split(output, "\n")
  local exts = { ".cpp", ".c", ".hpp", ".h", ".cxx" }
  files = vim.tbl_filter(function(file)
    local ext = file:match("^.+(%..+)$")
    return vim.tbl_contains(exts, ext)
  end, files)
  if #files == 0 then
    return ""
  end
  local ret = ""
  for _, file in ipairs(files) do
    ret = ret .. " " .. file
  end
  return ret
end

return {
  s(
    "version",
    fmt("cmake_minimum_required(VERSION {})", {
      f(function(_, _, _)
        local cmake_version, _ = get_cmake_version()
        return cmake_version
      end, {}, {}),
    })
  ),
  s("project", fmt("project({} VERSION {} LANGUAGES {})", { i(1, "main"), i(2, "1.0.0"), i(0, "CXX") })),
  s(
    "add_exe",
    fmt("add_executable(${}{})", {
      t("{PROJECT_NAME}"),
      f(function(_, _, _)
        return get_cmake_sources(".")
      end, {}, {}),
    })
  ),
  s(
    "fetchd",
    fmt(
      "FetchContent_Declare(\n\t{}\n\tGIT_REPOSITORY {}\n\tGIT_TAG {}\n)",
      { i(1, "target_name"), i(2, "repo"), i(3, "tag") }
    )
  ),
  s("fetchm", fmt("FetchContent_MakeAvailable({})", { i(1) })),
}
