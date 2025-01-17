local M = {}

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
  { "r", "<cmd>FzfLua grep_project<cr>", "Live Grep" },
  { "b", "<cmd>FzfLua buffers<cr>", "Search Buffers" },
  { "o", "<cmd>FzfLua oldfiles<cr>", "Search Recent Files" },
  { "R", "<cmd>FzfLua resume<cr>", "Resume Previous Picker" },
  {
    "m",
    function()
      require("core.search_utils").custom_search()
    end,
    "Telescope Custom Search",
  },
  { "C", "<cmd>FzfLua grep_curbuf<cr>", "Current Buffer Fuzzy Find" },
}

return M
