local dap_signs = {
  breakpoint = { text = "", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" },
  breakpoint_rejected = { text = "", texthl = "LspDiagnosticsSignHint", linehl = "", numhl = "" },
  stopped = {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", dap_signs.breakpoint_rejected)
vim.fn.sign_define("DapStopped", dap_signs.stopped)
