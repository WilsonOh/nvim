local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Diagnostics

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

vim.diagnostic.config({
  virtual_text = {
    source = "always", -- Or "if_many"
  },
  float = {
    source = "always", -- Or "if_many"
  },
})

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Show icons in autocomplete
require("vim.lsp.protocol").CompletionItemKind = {
  "",
  "",
  "ƒ",
  " ",
  "",
  "",
  "",
  "ﰮ",
  "",
  "",
  "",
  "",
  "了",
  " ",
  "﬌ ",
  " ",
  " ",
  "",
  " ",
  " ",
  " ",
  " ",
  "",
  "",
  "<>",
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = { source = "always", "spacing = 5", severity_limit = "Warning" },
  update_in_insert = true,
})
