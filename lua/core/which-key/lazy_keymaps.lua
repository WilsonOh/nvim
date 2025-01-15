local M = {}

M.meta = {
  group = "Lazy",
  prefix = "p",
}

M.mappings = {
  { "r", require("lazy").clean, "Remove Unused Plugins" },
  { "i", require("lazy").install, "Install Plugins" },
  { "p", require("lazy").profile, "Lazy Profile" },
  { "s", require("lazy").sync, "Sync Plugins" },
  { "S", require("lazy").home, "Lazy Home" },
  { "u", require("lazy").update, "Update Plugins" },
}

return M
