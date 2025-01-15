local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  name = "lsp",
  dependencies = {
    "mfussenegger/nvim-jdtls",
    "b0o/schemastore.nvim",
    { "williamboman/mason.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "clangd", "pyright", "jsonls", "ts_ls", "html", "rust_analyzer" },
      },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
}

M.config = function()
  local lspconfig = require("lspconfig")
  local configs = require("core.plugins.lsp.configs")

  local lsp_servers = require("mason-lspconfig").get_installed_servers()
  for _, server in ipairs(lsp_servers) do
    lspconfig[server].setup(configs.get_lspconfig_opts(server))
  end

  require("core.plugins.lsp.settings")
end

return M
