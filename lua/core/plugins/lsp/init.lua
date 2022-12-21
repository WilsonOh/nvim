local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "simrat39/rust-tools.nvim",
    "p00f/clangd_extensions.nvim",
    "mfussenegger/nvim-jdtls",
    "b0o/schemastore.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-nvim-dap.nvim",
  },
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
    ensure_installed = { "sumneko_lua", "clangd", "pyright", "jsonls", "tsserver", "html", "rust_analyzer" },
  })

  require("mason-nvim-dap").setup({
    ensure_installed = { "python", "codelldb" },
    automatic_setup = true,
  })

  require("mason-nvim-dap").setup_handlers({
    function(source_name)
      require("mason-nvim-dap.automatic_setup")(source_name)
    end,
  })

  local lspconfig = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local utils = require("core.plugins.lsp.utils")

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, pattern = "*" })
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        pattern = "*",
        callback = function()
          utils.format(0)
        end,
      })
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

  local opts = { capabilities = capabilities }

  local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  require("mason-lspconfig").setup_handlers({
    -- Generic lspconfig setup
    function(server_name)
      lspconfig[server_name].setup(opts)
    end,
    -- Calling the setup function through language specific plugins
    ["rust_analyzer"] = function()
      require("rust-tools").setup({
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
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
      require("clangd_extensions").setup({ server = opts })
    end,
    -- LSPs with special settings
    ["sumneko_lua"] = function()
      lspconfig.sumneko_lua.setup({
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
        capabilities = capabilities,
        settings = {
          Lua = {
            -- runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            -- workspace = { library = vim.api.nvim_get_runtime_file("", true) },
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
    ["jdtls"] = function() end,
  })

  require("core.plugins.lsp.settings")
end

return M
