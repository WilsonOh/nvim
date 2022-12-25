local M = {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local cp = require("catppuccin.palettes").get_palette()

  local function get_extension_left(s, filetype)
    return {
      sections = {
        lualine_c = {
          {
            function()
              return s
            end,
            color = { fg = cp.base, bg = cp.blue, gui = "bold" },
            separator = { left = "", right = "" },
          },
        },
      },
      filetypes = { filetype },
    }
  end

  local function get_extension_center(s, filetype)
    return {
      sections = {
        lualine_c = {
          "%=",
          {
            function()
              return s
            end,
            color = { fg = cp.base, bg = cp.blue, gui = "bold" },
            separator = { left = "", right = "" },
          },
        },
      },
      filetypes = { filetype },
    }
  end

  local get_attached_null_ls_sources = function()
    local filetype = vim.bo.filetype
    local null_ls_sources = require("null-ls").get_sources()
    local ret = {}
    for _, source in pairs(null_ls_sources) do
      if source.filetypes[filetype] then
        if not vim.tbl_contains(ret, source.name) then
          table.insert(ret, source.name)
        end
      end
    end
    return ret
  end

  local lsp_client_name = function(expand_null_ls)
    local clients = {}
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
      if expand_null_ls then
        if client.name == "null-ls" then
          for _, source in pairs(get_attached_null_ls_sources()) do
            clients[#clients + 1] = source
          end
        else
          clients[#clients + 1] = client.name
        end
      else
        clients[#clients + 1] = client.name
      end
    end
    if #clients == 0 then
      return "No Active LSP"
    end
    return table.concat(clients, ", ")
  end

  local config = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
        { "filetype", icon_only = true, separator = "" },
        {
          "filename",
          symbols = { modified = " ", readonly = "[RO]" },
          separator = "",
          padding = { left = 0, right = 1 },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "encoding", "fileformat", { "filetype" } },
      lualine_z = {
        {
          function()
            return "[%l/%L] C:%c 並%p%% "
          end,
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      "quickfix",
      "nvim-dap-ui",
      "nvim-tree",
      "toggleterm",
      get_extension_center("Alpha α", "alpha"),
      get_extension_left("Trouble", "Trouble"),
      get_extension_center("Telescope 🔭", "TelescopePrompt"),
      get_extension_center("Packer", "packer"),
    },
  }

  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  ins_left({
    function()
      return "%="
    end,
    component_separators = "",
  })

  ins_left({
    function()
      return lsp_client_name(true)
    end,
    icon = " LSP:",
    component_separators = "",
    color = { fg = cp.base, bg = cp.blue, gui = "bold" },
    separator = { left = "", right = "" },
  })

  require("lualine").setup(config)
end

return M
