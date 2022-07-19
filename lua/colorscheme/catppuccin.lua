vim.cmd [[packadd catppuccin]]

require('catppuccin').setup({
  dim_inactive = { enabled = true, shade = 'dark', percentage = 0.15 },
  transparent_background = false,
  term_colors = true,
  compile = { enabled = true, path = vim.fn.stdpath 'cache' .. '/catppuccin', suffix = '_compiled' },
  styles = {
    comments = {},
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'bold' },
        hints = { 'bold' },
        warnings = { 'bold' },
        information = { 'bold' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    coc_nvim = false,
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = { enabled = true, show_root = true, transparent_panel = false },
    neotree = { enabled = false, show_root = true, transparent_panel = false },
    dap = { enabled = true, enable_ui = true },
    which_key = true,
    indent_blankline = { enabled = true, colored_indent_levels = true },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = false,
    telekasten = false,
    symbols_outline = true,
    mini = false,
  },
})

vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
vim.cmd [[colorscheme catppuccin]]
