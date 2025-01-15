local M = {}

M.meta = {
  group = "LSP",
  prefix = "l",
}
M.mappings = {
  { "i", ":LspInfo<CR>", "Get LSP Diagnostic Information" },
  { "k", vim.lsp.buf.signature_help, "Signature help" },
  { "w", vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
  { "W", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
  { "l", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folder" },
  { "D", ":Lspsaga peek_definition<CR>", "Peek Definition" },
  { "d", vim.lsp.buf.definition, "Go to definition" },
  { "r", vim.lsp.buf.references, "References" },
  { "R", vim.lsp.buf.rename, "Rename" },
  { "a", vim.lsp.buf.code_action, "Code actions" },
  { "e", vim.diagnostic.open_float, "Show line diagnostics" },
  { "n", vim.diagnostic.goto_next, "Go to next diagnostic" },
  { "N", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
  { "I", vim.cmd.Mason, "Open Up Mason Package Manager" },
  { "F", ":Lspsaga finder<CR>", "Open LSP Finder" },
  { "f", require("conform").format, "Format File" },
}

return M
