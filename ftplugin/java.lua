local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/wilsonoh/coding_stuff/java_projects/workspace/' .. project_name

local config = {
  cmd = {
    'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4', '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true', '-Dlog.level=ALL', '-Xms1g', '--add-modules=ALL-SYSTEM', '--add-opens',
    'java.base/java.util=ALL-UNNAMED', '--add-opens', 'java.base/java.lang=ALL-UNNAMED', '-jar',
    '/Users/wilsonoh/.local/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/Users/wilsonoh/.local/jdtls/config_mac/', '-data', workspace_dir
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor'
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })
  end
}

require('jdtls').start_or_attach(config)
