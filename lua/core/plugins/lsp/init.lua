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
    ensure_installed = { "lua_ls", "clangd", "pyright", "jsonls", "tsserver", "html", "rust_analyzer" },
  })

  require("neodev").setup({})

  local lspconfig = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, pattern = "*" })
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {})
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = "lsp_document_highlight",
          buffer = args.buf,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          group = "lsp_document_highlight",
          buffer = args.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

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
    ["tsserver"] = function()
      require("typescript").setup({
        server = {
          capabilities = capabilities,
        },
      })
    end,
    -- Don't do anything for jdtls as it's setup under the java.lua filetype autocommand
    ["jdtls"] = function() end,
  })

  require("core.plugins.lsp.settings")
end

return M
