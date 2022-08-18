local dap = require("dap")

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

local cpptools_path = require("mason-registry").get_package("cpptools"):get_install_path()

local cmd = cpptools_path .. "/extension/debugAdapters/bin/OpenDebugAD7"

dap.adapters.cppdbg = { id = "cppdbg", type = "executable", command = cmd }

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/sbin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}
