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
  {
    "D",
    function()
      Snacks.picker.diagnostics({
        severity = vim.diagnostic.severity.ERROR,
      })
    end,
    "Document Diagnostics",
  },
  {
    "d",
    function()
      Snacks.picker.lsp_definitions({ jump = { reuse_win = false } })
    end,
    "Go to definition",
  },
  { "r", Snacks.picker.lsp_references, "References" },
  { "R", vim.lsp.buf.rename, "Rename" },
  { "a", vim.lsp.buf.code_action, "Code actions" },
  { "e", vim.diagnostic.open_float, "Show line diagnostics" },
  {
    "n",
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end,
    "Go to next diagnostic",
  },
  {
    "N",
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end,
    "Go to previous diagnostic",
  },
  { "I", Snacks.picker.lsp_implementations, "LSP Implementations" },
  { "m", vim.cmd.Mason, "Open Up Mason Package Manager" },
  -- { "F", ":Lspsaga finder<CR>", "Open LSP Finder" },
  { "f", require("conform").format, "Format File" },
  { "t", Snacks.picker.lsp_type_definitions, "Go to type definition" },
  { "s", Snacks.picker.lsp_symbols, "LSP Document Symbols Picker" },
  { "S", Snacks.picker.lsp_workspace_symbols, "LSP Workspace Symbols Picker" },
}

return M
