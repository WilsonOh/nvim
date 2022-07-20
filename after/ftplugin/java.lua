local jdtls = require('jdtls')
local jdtls_dap = require('jdtls.dap')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/wilsonoh/java/workspace/' .. project_name

local home = os.getenv('HOME')

local current_os = io.popen('uname'):read('*a')

local config_dir = current_os == 'Darwin' and 'config_mac' or 'config_linux'

local config = {
  cmd = {
    'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4', '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true', '-Dlog.level=ALL', '-Xms1g', '--add-modules=ALL-SYSTEM', '--add-opens',
    'java.base/java.util=ALL-UNNAMED', '--add-opens', 'java.base/java.lang=ALL-UNNAMED', '-jar',
    '/home/wilsonoh/.local/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/home/wilsonoh/.local/jdtls/config_linux', '-data', workspace_dir,
    home .. '/.local/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', home .. '/.local/jdtls/' .. config_dir, '-data', workspace_dir,
  },
  on_attach = function(_, bufnr)
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    jdtls_dap.setup_dap_main_class_configs()

    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
  init_options = {
    bundles = {
      vim.fn.glob(
          '/home/wilsonoh/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.38.0/com.microsoft.java.debug.plugin-*.jar'),
    },
  },
}

jdtls.start_or_attach(config)