--------------------------------------Bootstrapping Packer----------------------------------
local execute = vim.api.nvim_command

local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

local packer = Vapour.utils.plugins.require('packer')

if not packer then return end

packer.init(Vapour.plugins.packer.init)
---------------------------------------------------------------------------------------------

--------------------------------Autocommand for PackerSync-----------------------------------
--[[ local packer_augroup = vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_clear_autocmds({ group = packer_augroup, buffer = 0 })
vim.api.nvim_create_autocmd("BufWritePost ", {
  pattern = "plugins/init.lua",
  group = packer_augroup,
  command = "PackerSync"
}) ]]
---------------------------------------------------------------------------------------------

local function is_enabled(plugin)
  return Vapour.plugins[plugin].enabled
end

local function get_cmp()
  if Vapour.plugins.lsp.enabled == true then
    return 'nvim-cmp'
  else
    return
  end
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Syntax Highlighting and Visual Plugins
  use {
    'norcalli/nvim-colorizer.lua',
    disable = not is_enabled('colorizer'),
    config = function()
      require('colorizer-config')
    end,
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline-config')
    end,
    disable = not is_enabled('bufferline'),
  }
  use {
    'tamton-aquib/staline.nvim',
    disable = not is_enabled('staline'),
    config = function()
      require('staline-config')
    end,
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    disable = not is_enabled('indent_blankline'),
    config = function()
      require('blankline-config')
    end,
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode-config')
    end,
    disable = not is_enabled('zen_mode'),
  }
  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight-config')
    end,
    disable = not is_enabled('twilight'),
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    disable = not is_enabled('gitsigns'),
    config = function()
      require('gitsigns-config')
    end,
  }
  use { 'kyazdani42/nvim-web-devicons' }

  -- Tree-Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    disable = not is_enabled('treesitter'),
    config = function()
      require('treesitter-config')
    end,
  }
  use { 'p00f/nvim-ts-rainbow', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }
  use { 'windwp/nvim-ts-autotag', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }
  use {
    'RRethy/nvim-treesitter-endwise',
    disable = not is_enabled('treesitter'),
    after = 'nvim-treesitter',
  }
  use {
    'RRethy/nvim-treesitter-textsubjects',
    disable = not is_enabled('treesitter'),
    after = 'nvim-treesitter',
  }

  -- Colorschemes
  use { 'rose-pine/neovim', as = 'rose-pine', opt = true }
  use { 'joshdick/onedark.vim', opt = true }
  use { 'gruvbox-community/gruvbox', opt = true }
  use { 'shaunsingh/nord.nvim', opt = true }
  use { 'folke/tokyonight.nvim', opt = true }
  use { 'dracula/vim', as = 'dracula', opt = true }
  use { 'tiagovla/tokyodark.nvim', opt = true }
  use { 'catppuccin/nvim', as = 'catppuccin', opt = true }

  -- LSP and Autocomplete
  use { 'neovim/nvim-lspconfig', after = 'nvim-lsp-installer', disable = not is_enabled('lsp') }
  use { 'williamboman/nvim-lsp-installer', disable = not is_enabled('lsp') }
  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind-config')
    end,
    disable = not is_enabled('lsp'),
  }
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('cmp-config')
    end,
    disable = not is_enabled('lsp'),
  }
  use { 'hrsh7th/cmp-nvim-lsp', disable = not is_enabled('lsp') }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  use {
    'uga-rosa/cmp-dictionary',
    after = 'nvim-cmp',
    disable = not is_enabled('lsp'),
    config = function()
      require('cmp_dictionary').setup({ dic = { ['text,markdown'] = { '/usr/share/dict/words' } } })
    end,
  }
  use { 'tzachar/fuzzy.nvim', requires = { 'nvim-telescope/telescope-fzf-native.nvim' } }
  use { 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use {
    'windwp/nvim-autopairs',
    after = get_cmp(),
    config = function()
      require('autopairs-config')
    end,
    disable = not is_enabled('autopairs'),
  }
  use { 'b0o/schemastore.nvim', after = 'nvim-lsp-installer', disable = not is_enabled('lsp') }

  -- Terminal Integration
  use {
    'akinsho/nvim-toggleterm.lua',
    disable = not is_enabled('toggleterm'),
    config = function()
      require('toggleterm-config')
    end,
  }

  -- Navigation
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', disable = not is_enabled('lsp') }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    disable = not is_enabled('telescope'),
    cmd = 'Telescope',
    module = 'telescope',
    config = function()
      require('telescope-config')
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    disable = not is_enabled('nvim_tree'),
    config = function()
      require('nvimtree-config')
    end,
  }

  -- Other
  use {
    'jose-elias-alvarez/null-ls.nvim',
    disable = not is_enabled('null_ls'),
    config = function()
      require('null-ls-config')
    end,
  }
  use { 'folke/which-key.nvim', event = 'BufWinEnter' }
  ----------My Personal Plugins-------------------------
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use { 'wellle/targets.vim' }
  use { 'andymass/vim-matchup' }
  use { 'ggandor/lightspeed.nvim' }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({ cursor_scrolls_alone = false })
    end,
  }
  use { 'rafamadriz/friendly-snippets' }
  use { 'mfussenegger/nvim-jdtls' }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'zane-/cder.nvim' }
  use { 'ThePrimeagen/harpoon' }
  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require('navic-config')
    end,
  }
  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({ func_map = { ptogglemode = 'a' } })
    end,
  }
  use { 'moll/vim-bbye' }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha-config')
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end,
  }
  -- nvim-dap
  use { 'mfussenegger/nvim-dap' }
  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python', {})
    end,
  }
  use {
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui-config')
    end,
  }
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end,
  }
  --------------------------------------------------------
  for _, plugin in pairs(Vapour.plugins.user) do use(plugin) end
end)
