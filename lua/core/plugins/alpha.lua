local M = {
  "goolord/alpha-nvim",
  lazy = false,
}

M.config = function()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local header = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#1b63a6", bold = true })
  vim.api.nvim_set_hl(0, "AlphaInfo", { fg = "#8aa61b", bold = true })

  dashboard.section.header.type = "text"
  dashboard.section.header.val = header
  dashboard.section.header.opts = { position = "center", hl = "AlphaHeader" }

  local core_config_path = vim.fn.stdpath("config") .. "/lua/core/init.lua"
  local map_opts = { silent = true }
  dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>", map_opts),
    dashboard.button("f", "  > Find file", ":Telescope find_files<CR>", map_opts),
    dashboard.button(
      "c",
      "  > Search Configs",
      ":lua require('core.plugins.telescope.utils').config_search()<CR>",
      map_opts
    ),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>", map_opts),
    dashboard.button("s", "  > Settings", string.format(":e %s<CR>", core_config_path), map_opts),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>", map_opts),
  }

  local function footer()
    local plugins = require("lazy").stats().count
    local v = vim.version()
    return string.format(" v%d.%d.%d   %d", v.major, v.minor, v.patch, plugins)
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts = { position = "center", hl = "AlphaInfo" }

  local section = {
    header = dashboard.section.header,
    buttons = dashboard.section.buttons,
    footer = dashboard.section.footer,
  }

  local opts = {
    layout = {
      { type = "padding", val = 5 },
      section.header,
      { type = "padding", val = 1 },
      { type = "padding", val = 2 },
      section.buttons,
      section.footer,
    },
    opts = { margin = 5 },
  }

  alpha.setup(opts)

  vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = "alpha_tabline",
    pattern = "alpha",
    command = "set showtabline=0 noruler | set laststatus=0",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = "alpha_tabline",
    pattern = "alpha",
    callback = function()
      vim.api.nvim_create_autocmd("BufUnload", {
        group = "alpha_tabline",
        buffer = 0,
        command = "set showtabline=2 ruler",
      })
    end,
  })
end

return M
