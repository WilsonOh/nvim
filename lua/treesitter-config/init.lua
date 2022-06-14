Vapour.utils.plugins.packadd('nvim-treesitter')

Vapour.utils.plugins.require'nvim-treesitter.install'.compilers = { 'clang' }

Vapour.utils.plugins.require'nvim-treesitter.configs'.setup {
  enabled = true,
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  indent = { enable = false },
  highlight = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
  rainbow = { enable = true, extended_mode = false, disable = { 'html' } },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },
}
