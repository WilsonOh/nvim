vim.lsp.config("lua_ls", {
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

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "recommended",
      },
    },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.config("cssls", {
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
})

require("core.lsp.settings")

vim.lsp.enable({
  -- "basedpyright",
  -- "clangd",
  "emmet_language_server",
  "emmet_ls",
  "gopls",
  "html",
  "jdtls",
  "jsonls",
  "lua_ls",
  "ruff",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  -- "ts_ls",
  "xmlformatter",
  "zls",
  "docker_compose_language_service",
  "protols",
  "yamlls"
})
