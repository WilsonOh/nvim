local M = {
  "kyazdani42/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  enabled = true,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree" },
    { "<leader>E", "<cmd>NvimTreeFocus<cr>", desc = "Focus Nvim Tree" },
  },
}

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "<C-o>", api.tree.change_root_to_parent, opts("Up"))

  vim.keymap.set("n", "<C-f>", function()
    api.tree.close()
    api.tree.open({ find_file = true, update_root = true })
  end, opts("Update root to current file"))

  vim.keymap.set("n", "<C-c>", function()
    local global_cwd = vim.fn.getcwd(-1, -1)
    api.tree.change_root(global_cwd)
  end, opts("Change Root To Global CWD"))
end

M.config = function()
  -- local nvimtree_width = math.ceil(vim.api.nvim_win_get_width(0) * 0.3)

  require("nvim-tree").setup({
    on_attach = on_attach,
    -- filters = { custom = { "*.tmp", ".git" } },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    update_focused_file = { enable = true, update_root = false, ignore_list = {} },
    view = {
      width = 50,
      side = "left",
    },
    renderer = {
      indent_markers = { enable = true, icons = { corner = "└ ", edge = "│ ", none = "  " } },
    },
    diagnostics = { enable = true },
  })
  --   vim.cmd([[
  -- autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  -- ]])
end

return M
