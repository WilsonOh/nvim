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
        ensure_installed = { "lua_ls", "clangd", "jsonls", "ts_ls", "html", "rust_analyzer" },
      },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
  },
}

M.config = function()
  local lspconfig = require("lspconfig")
  local configs = require("core.plugins.lsp.configs")

  local mason_lsp_servers = require("mason-lspconfig").get_installed_servers()
  local custom_lsp_servers = { "fish_lsp" }
  local lsp_servers = vim.tbl_extend("force", mason_lsp_servers, custom_lsp_servers)
  local exclude = { "jdtls" }

  for _, server in ipairs(lsp_servers) do
    if not vim.list_contains(exclude, server) then
      lspconfig[server].setup(configs.get_lspconfig_opts(server))
    end
  end

  require("core.plugins.lsp.settings")
end

return M
