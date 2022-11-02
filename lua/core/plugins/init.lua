--------------------------------------Bootstrapping Packer----------------------------------
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").init({
  max_jobs = 20,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  -- Syntax Highlighting and Visual Plugins

  -- Enables color highlights within the buffer
  -- when a valid color string is input e.g. #123
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer-config")
    end,
    ft = { "html", "css" },
  })

  -- Adds a lot of functionality to the buffer tabs at the top
  -- Also adds the ability to customize its looks
  use({
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline-config")
    end,
    event = "BufWinEnter",
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine-config")
    end,
  })

  -- Show the indent lines in the buffer
  -- Additionally adds listchars for eol and whitespace
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("blankline-config")
    end,
  })

  -- vscode-like zen-mode
  --[[ use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode-config")
    end,
    cmd = "ZenMode",
  })
  use({
    "folke/twilight.nvim",
    config = function()
      require("twilight-config")
    end,
    cmd = { "Twilight", "TwilightEnable" },
  }) ]]
  ------------------------------

  -- Useful indicators at the columnsign to show git changes
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
  })

  -- Nice icons for different filetypes
  use({ "kyazdani42/nvim-web-devicons" })

  -- Tree-Sitter + related plugins
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("treesitter-config")
    end,
  })

  -- Rainbow colors for nested brackets
  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

  -- Auto close/delete tags in HTML
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

  -- Auto complete the relevant syntax e.g. in lua: function() -> <CR> end
  use({ "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" })

  -- Make everything a textobject - e.g. functions, classes, comments, conditionals etc.
  -- VERY useful but functionality is limited for some languages
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })

  -- Explore the treesitter-generated AST of the current buffer
  use({ "nvim-treesitter/playground" })
  -----------------------------------------------------------

  -- Colorschemes
  use({ "rose-pine/neovim", as = "rose-pine", opt = true })
  use({ "ellisonleao/gruvbox.nvim", as = "gruvbox", opt = true })
  use({ "catppuccin/nvim", as = "catppuccin", opt = true, run = "CatppuccinCompile" })
  use({ "rebelot/kanagawa.nvim", as = "kanagawa", opt = true })
  -------------------------------------------------------------

  -- LSP and Autocomplete

  -- Make configuring the native LSP easy
  use({ "neovim/nvim-lspconfig" })

  -- LSP Extensions
  use({ "simrat39/rust-tools.nvim" })
  use({ "p00f/clangd_extensions.nvim" })
  use({ "mfussenegger/nvim-jdtls" })
  use({ "b0o/schemastore.nvim" })

  -- Make configuring the natice LSP even easier
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "single",
          icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
        },
      })
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({ ensure_installed = { "sumneko_lua", "clangd", "pyright" } })
    end,
  })

  -- Provide nice vscode-like icons for autocomplete
  use({
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind-config")
    end,
  })

  -- autocomplete engine + completion source plugins
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp-config")
    end,
  })

  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  })

  -- Provide completion source from the LSP
  use({ "hrsh7th/cmp-nvim-lsp" })

  -- Provide completion source from buffer
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

  -- Provide path completion
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

  -- Provide completion source from system dictionary (have to install it yourself)
  use({
    "uga-rosa/cmp-dictionary",
    after = "nvim-cmp",
    config = function()
      require("cmp_dictionary").setup({ dic = { ["text,markdown"] = { "/usr/share/dict/words" } } })
    end,
  })
  -- use({ "hrsh7th/cmp-emoji" })
  --------------------------------------------------------------------------------

  -- Snippet engine + related plugins
  use({
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("snippets")
    end,
  })
  -- completion source from luasnip
  use({ "saadparwaiz1/cmp_luasnip" })
  ----------------------------------

  -- Autocomplete/delete brackets and quotes
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("autopairs-config")
    end,
  })

  -- Terminal Integration
  use({
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm-config")
    end,
  })

  -- Navigation
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    cmd = { "Telescope", "h telescope" },
    module = "telescope",
    config = function()
      require("telescope-config")
    end,
  })

  -- Highly functional directory tree viewer
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("nvimtree-config")
    end,
  })

  -- Aggregate LSP provider - very useful for formatters
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls-config")
    end,
  })

  -- VERY useful plugin for keymaps, especially multi-key keymaps
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key-config")
    end,
  })

  -- Modern vim-surround replacement which supports lua functions
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  })

  -- Extend dot-repeat functionality to plugins
  use({ "tpope/vim-repeat" })

  -- Make extent vim motions e.g. c2ib to change in the *outer* bracket
  use({ "wellle/targets.vim" })

  -- Extend % functionality based on the language e.g. function() -> end in lua
  -- Also gives a nice highlight when hovering over pairs
  use({
    "andymass/vim-matchup",
    config = function()
      require("matchup-config")
    end,
  })
  -- Zoom around the file
  -- use({ "ggandor/lightspeed.nvim" })

  -- Modern comment plugin which leverages Treesitter to do cool stuff like commenting out a function
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("comment-config")
    end,
  })

  -- Nice smooth scrolling use ctrl-d and ctrl-u etc.
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({ cursor_scrolls_alone = false })
    end,
  })

  -- Provide a good bit of vscode-style snippets, to be used with luasnip
  use({ "rafamadriz/friendly-snippets" })

  -- Show the context of the function/class at the top when you're in a long function
  use({ "nvim-treesitter/nvim-treesitter-context" })

  -- Project specific marks with a handy UI
  use({ "ThePrimeagen/harpoon", module_pattern = { "harpoon", "harpoon.ui", "harpoon.mark" } })

  -- Adds functionality to the quickfix list, such as a "magic window"
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({ func_map = { ptogglemode = "a" } })
    end,
  })

  -- Better bdelete and !bdelete
  use({ "moll/vim-bbye" })

  -- Neovim greeter
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha-config")
    end,
  })

  -- Gather all LSP diagnostics in one place
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    cmd = "Trouble*",
  })

  -- nvim-dap + related plugins
  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("dap-config")
    end,
  })

  use({
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python", {})
    end,
  })

  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui-config")
    end,
  })

  use({
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  })
  ----------------------------------------------------

  -- Nice loading spinner to indicate LSP startup progress (esp. for sumneko lua)
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({ text = { spinner = "dots" } })
    end,
  })

  -- Hydra.nvim stuff
  use({
    "anuvyklack/hydra.nvim",
    config = function()
      require("hydra-config")
    end,
    keys = { "<leader>d", "<leader>g" },
  })

  -- Adds extra concealment for markdown files i.e. conceal links
  use({ "preservim/vim-markdown", ft = { "markdown" } })
  ----------------------------------

  -- VERY useful multicursor plugin
  use({
    "mg979/vim-visual-multi",
    config = function()
      require("vim-visual-multi-config")
    end,
  })

  -- Color picker in Neovim
  use({
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup()
    end,
  })

  -- Nice highlighting and icons for todos and notes etc.
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  })

  use({ "lewis6991/impatient.nvim" })

  use({ "dstein64/vim-startuptime" })

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- use({ "sheerun/vim-polyglot" })

  use({
    "WilsonOh/emoji_picker-nvim",
    config = function()
      require("emoji_picker").setup({})
    end,
  })

  use({
    "folke/noice.nvim",
    config = function()
      require("noice-config")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })

  if Packer_bootstrap then
    require("packer").sync()
  end
end)
