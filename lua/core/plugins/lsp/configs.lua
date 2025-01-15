local M = {}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(false, {
      bufnr = bufnr,
    })
  end
end

M.capabilities = require("blink.cmp").get_lsp_capabilities()

--- @type lspconfig.Config
M.opts = {
  capabilities = M.capabilities,
  single_file_support = true,
  on_attach = M.on_attach,
}

M.custom_configs = {
  ["ocamllsp"] = {
    settings = {
      codelens = { enable = true },
    },
  },
  ["jsonls"] = {
    settings = {
      json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
    },
  },
  ["arduino_language_server"] = {
    cmd = {
      "arduino-language-server",
      "-clangd",
      "/usr/local/bin/clangd",
      "-cli",
      "/opt/homebrew/bin/arduino-cli",
      "-cli-config",
      "/Users/wilsonoh/Library/Arduino15/arduino-cli.yaml",
      "-fqbn",
      "arduino:avr:uno",
    },
  },
  ["rust_analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  ["lua_ls"] = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  ["cssls"] = {
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
}

--- @param server string: name of lsp server
--- @return lspconfig.Config
M.get_lspconfig_opts = function(server)
  if M.custom_configs[server] == nil then
    return M.opts
  end
  return vim.tbl_deep_extend("force", M.opts, M.custom_configs[server])
end

return M
