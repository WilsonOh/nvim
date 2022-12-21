local M = {
  "kyazdani42/nvim-tree.lua",
  cmd = "NvimTreeToggle",
}

M.config = function()
  local nvimtree_width = math.ceil(vim.api.nvim_win_get_width(0) * 0.3)

  require("nvim-tree").setup({
    filters = { custom = { "*.tmp", ".git" } },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = true,
    ignore_ft_on_setup = { "alpha" },
    open_on_tab = false,
    hijack_cursor = true,
    update_focused_file = { enable = true, update_root = true, ignore_list = {} },
    view = { width = nvimtree_width, side = "left", mappings = { custom_only = false, list = {} } },
    renderer = {
      indent_markers = { enable = true, icons = { corner = "└ ", edge = "│ ", none = "  " } },
    },
    diagnostics = { enable = true },
  })
  vim.cmd([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
end

return M
