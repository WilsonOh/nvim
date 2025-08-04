local M = {}

M.meta = {
  group = "Files",
  prefix = "f",
}

M.mappings = {
  {
    "H",
    Snacks.picker.command_history,
    "Search Current Buffer Directory",
  },
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
      -- require("core.search_utils").project_search()
      -- local root = vim.fs.root(0, { "go.mod", "package.json", ".git" })
      -- Snacks.picker.files({ cwd = root })
      Snacks.picker.files()
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
    "g",
    function()
      Snacks.picker.git_files()
    end,
    "Search Git Files",
  },
  {
    "w",
    function()
      Snacks.picker.grep_word()
    end,
    "Grep word",
  },
  {
    "r",
    function()
      -- local root = vim.fs.root(0, { "go.mod", "package.json", ".git" })
      -- Snacks.picker.grep({ cwd = root })
      Snacks.picker.grep()
    end,
    "Live Grep",
  },
  {
    "s",
    function()
      Snacks.picker.smart()
    end,
    "Smart Search Files",
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
    -- "<cmd>FzfLua resume<cr>",
    Snacks.picker.resume,
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
    "<cmd>FzfLua grep_curbuf<cr>",
    "Current Buffer Fuzzy Find",
  },
}

return M
