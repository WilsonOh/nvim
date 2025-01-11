local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  name = "lsp",
  dependencies = { "folke/neodev.nvim" },
}

M.config = function()
  require("mason").setup({
    ui = {
      border = "single",
      icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
    },
  })

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = { "lua_ls", "clangd", "pyright", "jsonls", "ts_ls", "html", "rust_analyzer" },
  })

  require("neodev").setup({})

  local lspconfig = require("lspconfig")

  local capabilities = require('blink.cmp').get_lsp_capabilities() --require("cmp_nvim_lsp").default_capabilities()
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local opts = { capabilities = capabilities, single_file_support = true }

  require("mason-lspconfig").setup_handlers({
    -- Generic lspconfig setup
    function(server_name)
      lspconfig[server_name].setup(opts)
    end,
    -- Calling the setup function through language specific plugins
    ["rust_analyzer"] = function()
      require("rust-tools").setup({
        dap = {
          adapter = false,
        },
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
          capabilities = capabilities,
        },
      })
    end,
    ["clangd"] = function()
      local clang_d_capabilities = capabilities
      clang_d_capabilities.offsetEncoding = { "utf-16" }
      lspconfig.clangd.setup({ capabilities = clang_d_capabilities })
      -- require("clangd_extensions").setup({ server = { capabilities = clang_d_capabilities } })
    end,
    -- LSPs with special settings
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
    end,
    ["jsonls"] = function()
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
        },
      })
    end,
    ["ts_ls"] = function()
      require("typescript-tools").setup({
        capabilities = capabilities,
      })
    end,
    -- Don't do anything for jdtls as it's setup under the java.lua filetype autocommand
    ["jdtls"] = function() end,
    ["ocamllsp"] = function()
      lspconfig.ocamllsp.setup({
        settings = {
          codelens = { enable = true },
        },
        capabilities = capabilities,
        filetypes = { "ocaml" },
      })
    end,

    ["cssls"] = function()
      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            }
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            }
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            }
          },
        },
      })
    end,
    ["arduino_language_server"] = function()
      lspconfig["arduino_language_server"].setup({
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-clangd", "/usr/local/bin/clangd",
          "-cli", "/opt/homebrew/bin/arduino-cli",
          "-cli-config", "/Users/wilsonoh/Library/Arduino15/arduino-cli.yaml",
          "-fqbn", "arduino:avr:uno"
        }
      })
    end
  })

  require("core.plugins.lsp.settings")
end

return M
