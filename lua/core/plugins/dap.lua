local M = {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          {
            "theHamsta/nvim-dap-virtual-text",
            config = function()
              require("nvim-dap-virtual-text").setup({})
            end,
          },
        },
        config = function()
          require("dapui").setup()
        end,
      },
    },
  },
}

M.config = function()
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

  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
