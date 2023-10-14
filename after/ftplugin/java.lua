-- Set java indent options
vim.o.shiftwidth = 4
vim.o.tabstop = 4

local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local current_os = io.popen("uname"):read("*a"):gsub("%s", "")

local home = os.getenv("HOME")

local workspace_root = current_os == "Darwin" and "/coding_stuff/java_projects/workspaces/" or "/java/workspaces/"

local workspace_dir = home .. workspace_root .. project_name

local config_dir = current_os == "Darwin" and "config_mac" or "config_linux"

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()

local jdtls_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"

local jdtls_config = jdtls_path .. "/" .. config_dir

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
  --[[ init_options = {
		bundles = {
			vim.fn.glob(
				"/Users/wilsonoh/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.38.0/com.microsoft.java.debug.plugin-0.38.0.jar"
			),
		},
	} ]]
}

jdtls.start_or_attach(config)
