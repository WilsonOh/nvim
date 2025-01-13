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

vim.diagnostic.config({
  virtual_text = {
    source = true, -- Or "if_many"
  },
  float = {
    source = true, -- Or "if_many"
  },
})

-- local hl = "DiagnosticSign" .. type
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    texthl = {},
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
  },
})
-- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })

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
  virtual_text = { source = "always", "spacing = 5", min = vim.diagnostic.severity.WARN },
  update_in_insert = true,
})
