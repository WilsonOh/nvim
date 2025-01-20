local M = {}

local picker = Snacks.picker

M.meta = {
  group = "Files",
  prefix = "f",
}

M.mappings = {
  {
    "f",
    function()
      require("core.search_utils").search_current_buf_dir()
    end,
    "Search Current Buffer Directory",
  },
  {
    "c",
    function()
      require("core.search_utils").config_search()
    end,
    "Search Config",
  },
  {
    "p",
    function()
      require("core.search_utils").project_search()
    end,
    "Search Project",
  },
  { "P", require("core.search_utils").search_plugin_files, "Search Plugin Files" },
  {
    "h",
    function()
      Snacks.picker.help()
    end,
    "Search Help",
  },
  {
    "w",
    function()
      Snacks.picker.grep_word()
    end,
    "Search Plugin Files",
  },
  {
    "r",
    function()
      picker.grep()
    end,
    "Live Grep",
  },
  {
    "b",
    function()
      Snacks.picker.buffers()
    end,
    "Search Buffers",
  },
  {
    "o",
    function()
      Snacks.picker.recent()
    end,
    "Search Recent Files",
  },
  {
    "R",
    function()
      picker.resume()
    end,
    "Resume Previous Picker",
  },
  {
    "m",
    function()
      require("core.search_utils").custom_search()
    end,
    "Search Directory from Input",
  },
  {
    "C",
    function()
      picker.lines()
    end,
    "Current Buffer Fuzzy Find",
  },
}

return M
