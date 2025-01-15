local M = {}

M.meta = {
  group = "Files",
  prefix = "f",
}

M.mappings = {
  {
    "f",
    function()
      require("core.plugins.telescope.utils").search_current_buf_dir()
    end,
    "Search Current Buffer Directory",
  },
  {
    "c",
    function()
      require("core.plugins.telescope.utils").config_search()
    end,
    "Search Config",
  },
  {
    "p",
    function()
      require("core.plugins.telescope.utils").project_search()
    end,
    "Search Project",
  },
  { "P", require("core.plugins.telescope.utils").search_plugin_files, "Search Plugin Files" },
  { "r", "<cmd>FzfLua grep_project<cr>", "Live Grep" },
  { "b", ":Telescope buffers bufnr=0<CR>", "Buffers" },
  { "o", ":Telescope oldfiles<CR>", "Recent Files" },
  { "R", ":Telescope resume<CR>", "Resume Previous Picker" },
  {
    "m",
    function()
      require("core.plugins.telescope.utils").custom_search()
    end,
    "Telescope Custom Search",
  },
  { "C", "<cmd>FzfLua grep_curbuf<cr>", "Current Buffer Fuzzy Find" },
}

return M
