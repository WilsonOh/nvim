local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local current_os = io.popen("uname"):read("*a"):gsub("%s", "")

local home = os.getenv("HOME")

local workspace_root = current_os == "Darwin" and "/coding_stuff/java_projects/workspaces/" or "/java/workspaces/"

local workspace_dir = home .. workspace_root .. project_name

local config_dir = current_os == "Darwin" and "config_mac" or "config_linux"

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()

local jdtls_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

local jdtls_config = jdtls_path .. "/" .. config_dir

local utils = require("language-servers.utils")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    jdtls_jar,
    "-configuration",
    jdtls_config,
    "-data",
    workspace_dir,
  },
  on_attach = function(client, bufnr)
    -- jdtls.setup_dap({ hotcodereplace = "auto" })
    -- jdtls_dap.setup_dap_main_class_configs()

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          utils.filtered_formatters(bufnr)
        end,
      })
    end
  end,
  --[[ init_options = {
		bundles = {
			vim.fn.glob(
				"/Users/wilsonoh/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.38.0/com.microsoft.java.debug.plugin-0.38.0.jar"
			),
		},
	} ]]
}

jdtls.start_or_attach(config)
