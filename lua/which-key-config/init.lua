Vapour.utils.plugins.packadd('which-key.nvim')

local wk = Vapour.utils.plugins.require('which-key')
local saga_diag = require('lspsaga.diagnostic')
local saga_hover = require('lspsaga.hover')
local saga_rename = require('lspsaga.rename')
local dap = require('dap')
local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')

local mappings = {
  F = { '<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'Range Format File' },
  h = {
    name = 'Harpoon',
    m = { harpoon_mark.add_file, 'Add Mark' },
    M = { harpoon_ui.toggle_quick_menu, 'Toggle Quick Menu' },
    n = { harpoon_ui.nav_next, 'Go To Next Mark' },
    ['1'] = {
      function()
        harpoon_ui.nav_file(1)
      end, 'Go To Mark 1',
    },
    ['2'] = {
      function()
        harpoon_ui.nav_file(2)
      end, 'Go To Mark 2',
    },
    ['3'] = {
      function()
        harpoon_ui.nav_file(3)
      end, 'Go To Mark 3',
    },
    ['4'] = {
      function()
        harpoon_ui.nav_file(4)
      end, 'Go To Mark 4',
    },
    p = { harpoon_ui.nav_prev, 'Go To Previous Mark' },
  },
  --[[ d = {
    name = 'Debug',
    b = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
    B = {
      function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, 'Set Conditional Breakpoint',
    },
    c = { dap.continue, 'Continue' },
    s = { dap.step_into, 'Step Into' },
    S = { dap.step_over, 'Step Over' },
    o = { dap.step_out, 'Step Out' },
    l = { dap.run_last, 'Run Last' },
    r = { dap.repl.toggle, 'Repl Open' },
  }, ]]
  l = {
    name = 'LSP',
    i = { ':LspInfo<cr>', 'Connected Language Servers' },
    k = { vim.lsp.buf.signature_help, 'Signature help' },
    K = { saga_hover.render_hover_doc, 'Hover' },
    w = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
    W = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      'List workspace folder',
    },
    t = { vim.lsp.buf.type_definition, 'Type definition' },
    d = { vim.lsp.buf.definition, 'Go to definition' },
    r = { '<cmd>Trouble lsp_references<CR>', 'References' },
    R = { saga_rename.lsp_rename, 'Rename' },
    a = { vim.lsp.buf.code_action, 'Code actions' },
    e = { saga_diag.show_line_diagnostics, 'Show line diagnostics' },
    n = { saga_diag.goto_next, 'Go to next diagnostic' },
    N = { saga_diag.goto_prev, 'Go to previous diagnostic' },
    I = { '<cmd>LspInstallInfo<cr>', 'Install language server' },
    f = { '<cmd>lua require("lsp_utils").filtered_formatters(0)<CR>', 'Format File' },
    T = { '<cmd>Trouble<CR>', 'Get Diagnostics' },
  },
  q = { '<cmd>copen<CR>', 'Open QuickFix List' },
  a = { 'ggVG', 'Select Entire Buffer' },
  x = { ':Bdelete<cr>', 'Close Buffer' },
  X = { ':Bdelete!<cr>', 'Force Close Buffer' },
  E = { ':e ~/.config/nvim/lua/vapour/user-config/init.lua<cr>', 'Edit User Config' },
  p = {
    name = 'Packer',
    r = { ':PackerClean<cr>', 'Remove Unused Plugins' },
    c = { ':PackerCompile profile=true<cr>', 'Recompile Plugins' },
    i = { ':PackerInstall<cr>', 'Install Plugins' },
    p = { ':PackerProfile<cr>', 'Packer Profile' },
    s = { ':PackerSync<cr>', 'Sync Plugins' },
    S = { ':PackerStatus<cr>', 'Packer Status' },
    u = { ':PackerUpdate<cr>', 'Update Plugins' },
  },
  z = {
    name = 'Focus',
    z = { ':ZenMode<cr>', 'Toggle Zen Mode' },
    t = { ':Twilight<cr>', 'Toggle Twilight' },
  },
  b = {
    name = 'Bufferline Options',
    c = { ':BufferLinePick<CR>', 'Choose Buffer' },
    n = { ':BufferLineMoveNext<CR>', 'Move buffer to the right' },
    p = { ':BufferLineMovePrev<CR>', 'Move buffer to the left' },
  },
}

if Vapour.plugins.nvim_tree.enabled then mappings.e = { ':NvimTreeToggle<cr>', 'File Explorer' } end

-- Alternative method to telescope.builtin.git_files for searching the project
--[[ vim.keymap.set('n', '<leader>fx', function()
  local project_root = vim.lsp.get_active_clients()[1].config.root_dir
  require('telescope.builtin').find_files({ cwd = project_root })
end) ]]

if Vapour.plugins.telescope.enabled then
  mappings.f = {
    name = 'Telescope',
    f = { '<cmd>Telescope find_files theme=ivy<cr>', 'Find Files' },
    c = { '<cmd>Telescope find_files cwd=~/.config/nvim/lua/ theme=ivy<cr>', 'Search Config' },
    g = { '<cmd>Telescope git_files theme=ivy<CR>', 'Search Project' },
    r = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    b = { '<cmd>Telescope buffers bufnr=0<cr>', 'Buffers' },
    o = { '<cmd>Telescope oldfiles<cr>', 'Recent Files' },
    R = { '<cmd>Telescope resume<cr>', 'Resume Previous Picker' },
    n = { '<cmd>Telescope neoclip<cr>', 'Open Clipboard' },
  }
end

if not Vapour.settings.always_force_write then
  mappings.W = { ':w!<cr>', 'Force Write' }
else
  -- map n mode w to w!
end

for plugin, plugin_options in pairs(Vapour.plugins) do
  if plugin_options.which_key ~= nil and plugin_options.enabled then
    local whichkey_opts = plugin_options.which_key

    local whichkey_mappings = {}

    if mappings[whichkey_opts.root] ~= nil then
      whichkey_mappings = mappings[whichkey_opts.root]

      for key, actions in pairs(mappings[whichkey_opts.root]) do
        whichkey_mappings[key] = actions
      end
    else
      whichkey_mappings = {
        -- Give a special name if provided otherwise just use the plugin name
        name = whichkey_opts.name or plugin,
      }
    end

    for key, actions in pairs(whichkey_opts.definitions) do whichkey_mappings[key] = actions end

    mappings[whichkey_opts.root] = whichkey_mappings
  end
end

mappings = Vapour.utils.tables.copy(mappings, Vapour.plugins.which_key.user_defined)

local opts = { prefix = '<leader>' }

if wk then wk.register(mappings, opts) end
