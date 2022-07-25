local function get_char_highlights()
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]
  return {
    'IndentBlanklineIndent1', 'IndentBlanklineIndent2', 'IndentBlanklineIndent3',
    'IndentBlanklineIndent4', 'IndentBlanklineIndent5', 'IndentBlanklineIndent6',
  }
end

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

local show_rainbow = false

require('indent_blankline').setup {
  show_end_of_line = false,
  space_char_blankline = ' ',
  filetype_exclude = { 'alpha', 'packer', 'NvimTree', 'mason.nvim' },
  buftype_exclude = { 'terminal' },
  show_current_context = true,
  char_highlight_list = show_rainbow and get_char_highlights() or {},
  context_patterns = {
    'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object',
    '^table', 'block', 'arguments', 'if_statement', 'else_clause', 'jsx_element',
    'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement',
    'operation_type',
  },
}
