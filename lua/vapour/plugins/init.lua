--------------------------------------Bootstrapping Packer----------------------------------
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path,
  })
end

local packer = Vapour.utils.plugins.require('packer')

if not packer then return end

packer.init(Vapour.plugins.packer.init)
---------------------------------------------------------------------------------------------

--------------------------------Autocommand for PackerSync-----------------------------------

--[[ local plugin_path = fn.stdpath('config') .. '/lua/vapour/plugins/init.lua'

local packer_augroup = vim.api.nvim_create_augroup('packer_user_config', {})
vim.api.nvim_clear_autocmds({ group = packer_augroup, buffer = 0 })
vim.api.nvim_create_autocmd('BufWritePost ', {
  pattern = plugin_path,
  group = packer_augroup,
  callback = function()
    vim.cmd '%so'
    vim.cmd 'PackerSync'
  end,
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

  -- Enables color highlights within the buffer
  -- when a valid color string is input e.g. #123
  use {
    'norcalli/nvim-colorizer.lua',
    disable = not is_enabled('colorizer'),
    config = function()
      require('colorizer-config')
    end,
  }

  -- Adds a lot of functionality to the buffer tabs at the top
  -- Also adds the ability to customize its looks
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline-config')
    end,
    disable = not is_enabled('bufferline'),
  }

  -- Highly configurable statusine plugin
  --[[ use {
    'tamton-aquib/staline.nvim',
    disable = not is_enabled('staline'),
    config = function()
      require('staline-config')
    end,
  } ]]

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine-config')
    end,
  }

  -- Show the indent lines in the buffer
  -- Additionally adds listchars for eol and whitespace
  use {
    'lukas-reineke/indent-blankline.nvim',
    disable = not is_enabled('indent_blankline'),
    config = function()
      require('blankline-config')
    end,
  }

  -- vscode-like zen-mode
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
  ------------------------------

  -- Useful indicators at the columnsign to show git changes
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    disable = not is_enabled('gitsigns'),
    config = function()
      require('gitsigns-config')
    end,
  }

  -- Nice icons for different filetypes
  use { 'kyazdani42/nvim-web-devicons' }

  -- Tree-Sitter + related plugins
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    disable = not is_enabled('treesitter'),
    config = function()
      require('treesitter-config')
    end,
  }
  -- Rainbow colors for nested brackets
  use { 'p00f/nvim-ts-rainbow', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }
  -- Auto close/delete tags in HTML
  use { 'windwp/nvim-ts-autotag', disable = not is_enabled('treesitter'), after = 'nvim-treesitter' }
  -- Auto complete the relevant syntax e.g. in lua: function() -> <CR> end
  use {
    'RRethy/nvim-treesitter-endwise',
    disable = not is_enabled('treesitter'),
    after = 'nvim-treesitter',
  }
  -- Make everything a textobject - e.g. functions, classes, comments, conditionals etc.
  -- VERY useful but functionality is limited for some languages
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  -- More general version of treesitter-objects, limited to visual mode only
  --[[ use {
    'RRethy/nvim-treesitter-textsubjects',
    disable = not is_enabled('treesitter'),
    after = 'nvim-treesitter',
  } ]]
  -- Explore the treesitter-generated AST of the current buffer
  use { 'nvim-treesitter/playground' }
  -----------------------------------------------------------

  -- Colorschemes
  use { 'rose-pine/neovim', as = 'rose-pine', opt = true }
  use { 'joshdick/onedark.vim', opt = true }
  use { 'gruvbox-community/gruvbox', opt = true }
  use { 'shaunsingh/nord.nvim', opt = true }
  use { 'folke/tokyonight.nvim', opt = true }
  use { 'dracula/vim', as = 'dracula', opt = true }
  use { 'tiagovla/tokyodark.nvim', opt = true }
  use { 'catppuccin/nvim', as = 'catppuccin', opt = true, run = 'CatppuccinCompile' }
  use { 'rebelot/kanagawa.nvim', as = 'kanagawa', opt = true }
  -------------------------------------------------------------

  -- LSP and Autocomplete

  -- Make configuring the native LSP easy
  use { 'neovim/nvim-lspconfig', after = 'nvim-lsp-installer', disable = not is_enabled('lsp') }
  -- Make configuring the natice LSP even easier
  use { 'williamboman/nvim-lsp-installer', disable = not is_enabled('lsp') }
  -- Provide nice vscode-like icons for autocomplete
  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind-config')
    end,
    disable = not is_enabled('lsp'),
  }
  -- autocomplete engine + completion source plugins
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('cmp-config')
    end,
    disable = not is_enabled('lsp'),
  }
  -- Provide completion source from the LSP
  use { 'hrsh7th/cmp-nvim-lsp', disable = not is_enabled('lsp') }
  -- Provide completion source from buffer
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  -- Provide path completion
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  -- Provide completion source for the command line
  -- use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp', disable = not is_enabled('lsp') }
  -- Provide completion source from system dictionary (have to install it yourself)
  use {
    'uga-rosa/cmp-dictionary',
    after = 'nvim-cmp',
    disable = not is_enabled('lsp'),
    config = function()
      require('cmp_dictionary').setup({ dic = { ['text,markdown'] = { '/usr/share/dict/words' } } })
    end,
  }
  use { 'hrsh7th/cmp-emoji' }
  --[[ use { 'tzachar/fuzzy.nvim', requires = { 'nvim-telescope/telescope-fzf-native.nvim' } }
  use { 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } } ]]
  --------------------------------------------------------------------------------

  -- Snippet engine + related plugins
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }
  -- completion source from luasnip
  use { 'saadparwaiz1/cmp_luasnip' }
  ----------------------------------

  -- Autocomplete/delete brackets and quotes
  use {
    'windwp/nvim-autopairs',
    after = get_cmp(),
    config = function()
      require('autopairs-config')
    end,
    disable = not is_enabled('autopairs'),
  }

  -- Provide JSON schemas
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
    cmd = { 'Telescope', 'h telescope' },
    module = 'telescope',
    config = function()
      require('telescope-config')
    end,
  }

  -- Highly functional directory tree viewer
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    disable = not is_enabled('nvim_tree'),
    config = function()
      require('nvimtree-config')
    end,
  }

  -- Aggregate LSP provider - very useful for formatters
  use {
    'jose-elias-alvarez/null-ls.nvim',
    disable = not is_enabled('null_ls'),
    config = function()
      require('null-ls-config')
    end,
  }

  -- VERY useful plugin for keymaps, especially multi-key keymaps
  use { 'folke/which-key.nvim', event = 'BufWinEnter' }
  ----------My Personal Plugins-------------------------
  --[[ use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({ toggle_key = '<C-x>' })
    end,
  } ]]
  -- use { 'tpope/vim-surround' }

  -- Modern vim-surround replacement which supports lua functions
  use({
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  })

  -- Extend dot-repeat functionality to plugins
  use { 'tpope/vim-repeat' }
  -- Make extent vim motions e.g. c2ib to change in the *outer* bracket
  use { 'wellle/targets.vim' }
  -- Extend % functionality based on the language e.g. function() -> end in lua
  -- Also gives a nice highlight when hovering over pairs
  use {
    'andymass/vim-matchup',
    config = function()
      require('matchup-config')
    end,
  }
  -- Zoom around the file
  use { 'ggandor/lightspeed.nvim' }

  -- Modern comment plugin which leverages Treesitter to do cool stuff like commenting out a function
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({ mappings = { extended = true } })
    end,
  }

  -- Nice smooth scrolling use ctrl-d and ctrl-u etc.
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({ cursor_scrolls_alone = false })
    end,
  }

  -- Provide a good bit of vscode-style snippets, to be used with luasnip
  use { 'rafamadriz/friendly-snippets' }

  -- Java specific LSP plugin, provides more code actions and debugger functionality
  use { 'mfussenegger/nvim-jdtls' }

  -- Show the context of the function/class at the top when you're in a long function
  use { 'nvim-treesitter/nvim-treesitter-context' }

  -- Project specific marks with a handy UI
  use { 'ThePrimeagen/harpoon' }

  -- Adds functionality to the quickfix list, such as a "magic window"
  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({ func_map = { ptogglemode = 'a' } })
    end,
  }

  -- Better bdelete and !bdelete
  use { 'moll/vim-bbye' }

  -- Neovim greeter
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha-config')
    end,
  }

  -- Gather all LSP diagnostics in one place
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end,
  }

  -- nvim-dap + related plugins
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap-config')
    end,
  }
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
  --------------------
  --
  --[[ use {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup()
    end,
  } ]]

  -- Nice loading spinner to indicate LSP startup progress (esp. for sumneko lua)
  use {
    'j-hui/fidget.nvim',
    config = function()
      require'fidget'.setup({ text = { spinner = 'dots' } })
    end,
  }

  -- Hydra.nvim stuff
  use {
    'anuvyklack/hydra.nvim',
    config = function()
      require('hydra-config')
    end,
  }
  use { 'preservim/vim-markdown' }
  ----------------------------------

  -- LSP Extensions
  use { 'simrat39/rust-tools.nvim' }
  -- use { 'p00f/clangd_extensions.nvim' }

  -- VERY useful multicursor plugin
  use {
    'mg979/vim-visual-multi',
    config = function()
      require('vim-visual-multi-config')
    end,
  }

  -- Color picker in Neovim
  use {
    'ziontee113/color-picker.nvim',
    config = function()
      require('color-picker')
    end,
  }

  -- Nice highlighting and icons for todos and notes etc.
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  }

  --[[ use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga-config')
    end,
  } ]]

  use { 'lewis6991/impatient.nvim' }

  for _, plugin in pairs(Vapour.plugins.user) do use(plugin) end

  if Packer_bootstrap then require('packer').sync() end

end)
