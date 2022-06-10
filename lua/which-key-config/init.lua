Vapour.utils.plugins.packadd('which-key.nvim')

local wk = Vapour.utils.plugins.require('which-key')

local mappings = {
  h = {
    name = "Harpoon",
    m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add Mark" },
    M = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Quick Menu" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Go To Next Mark" },
    ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Go To Mark 1" },
    ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Go To Mark 2" },
    ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Go To Mark 3" },
    ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Go To Mark 4" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Go To Previous Mark" }
  },
  l = {
    name = "LSP",
    i = { ":LspInfo<cr>", "Connected Language Servers" },
    k = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help" },
    K = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover" },
    w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add workspace folder" },
    W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove workspace folder" },
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      "List workspace folder"
    },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type definition" },
    d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition" },
    D = { '<cmd>lua vim.lsp.buf.delaration()<CR>', "Go to declaration" },
    r = { '<cmd>lua vim.lsp.buf.references()<CR>', "References" },
    R = { ':IncRename ', "Rename" },
    a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions" },
    e = { '<cmd>lua vim.diagnostic.open_float()<CR>', "Show line diagnostics" },
    n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', "Go to next diagnostic" },
    N = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Go to previous diagnostic" },
    I = { '<cmd>LspInstallInfo<cr>', 'Install language server' },
    f = { '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', "Format File" },
    T = { '<cmd> Telescope diagnostics bufnr=0<CR>', "Get Diagnostics" }
  },
  c = { "ggVGc", "Clear Buffer" },
  x = { ":bdelete<cr>", "Close Buffer" },
  X = { ":bdelete!<cr>", "Force Close Buffer" },
  q = { ":q<cr>", "Quit" },
  Q = { ":q!<cr>", "Force Quit" },
  w = { ":w<cr>", "Write" },
  E = { ":e ~/.config/nvim/lua/vapour/user-config/init.lua<cr>", "Edit User Config" },
  p = {
    name = "Packer",
    r = { ":PackerClean<cr>", "Remove Unused Plugins" },
    c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
    i = { ":PackerInstall<cr>", "Install Plugins" },
    p = { ":PackerProfile<cr>", "Packer Profile" },
    s = { ":PackerSync<cr>", "Sync Plugins" },
    S = { ":PackerStatus<cr>", "Packer Status" },
    u = { ":PackerUpdate<cr>", "Update Plugins" }
  },
  z = {
    name = "Focus",
    z = { ":ZenMode<cr>", "Toggle Zen Mode" },
    t = { ":Twilight<cr>", "Toggle Twilight" }
  }
}

if Vapour.plugins.nvim_tree.enabled then mappings.e = { ":NvimTreeToggle<cr>", "File Explorer" } end

if Vapour.plugins.dashboard.enabled then mappings.d = { ":Dashboard<cr>", "Dashboard" } end

if Vapour.plugins.telescope.enabled then
  mappings.f = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files theme=ivy<cr>", "Find Files" },
    c = { "<cmd>Telescope find_files cwd=~/.config/nvim/lua/ theme=ivy<cr>", "Search Config" },
    r = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    o = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
  }
end

if Vapour.plugins.nvim_comment.enabled then mappings["/"] = { ":CommentToggle<cr>", "Toggle Comment" } end

if not Vapour.settings.always_force_write then
  mappings.W = { ":w!<cr>", "Force Write" }
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
        name = whichkey_opts.name or plugin
      }
    end

    for key, actions in pairs(whichkey_opts.definitions) do whichkey_mappings[key] = actions end

    mappings[whichkey_opts.root] = whichkey_mappings
  end
end

mappings = Vapour.utils.tables.copy(mappings, Vapour.plugins.which_key.user_defined)

local opts = { prefix = "<leader>" }

wk.register(mappings, opts)
