--------------------------------------Bootstrapping Lazy----------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  -- Syntax Highlighting and Visual Plugins

  -- Enables color highlights within the buffer
  -- when a valid color string is input e.g. #123
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({
        highlighter = {
          auto_enable = true,
          filetypes = {
            "html",
            "jsx",
            "tsx",
            "js",
            "css",
            "ts",
            "json",
          },
        },
      })
    end,
  },

  -- Adds a lot of functionality to the buffer tabs at the top
  -- Also adds the ability to customize its looks
  {
    "akinsho/nvim-bufferline.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("bufferline-config")
    end,
    event = "BufWinEnter",
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("lualine-config")
    end,
  },

  -- Show the indent lines in the buffer
  -- Additionally adds listchars for eol and whitespace
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("blankline-config")
    end,
  },

  ------------------------------

  -- ful indicators at the columnsign to show git changes
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
  },

  -- Tree-Sitter + related plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    config = function()
      require("treesitter-config")
    end,
  },

  -- Rainbow colors for nested brackets
  "p00f/nvim-ts-rainbow",

  -- Auto close/delete tags in HTML
  "windwp/nvim-ts-autotag",

  -- Auto complete the relevant syntax e.g. in lua: function() -> <CR> end
  "RRethy/nvim-treesitter-endwise",

  -- Make everything a textobject - e.g. functions, classes, comments, conditionals etc.
  -- VERY ful but functionality is limited for some languages
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Explore the treesitter-generated AST of the current buffer
  "nvim-treesitter/playground",
  -----------------------------------------------------------

  -- Colorschemes
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "ellisonleao/gruvbox.nvim", name = "gruvbox", lazy = true },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    build = function()
      pcall(vim.cmd, "CatppuccinCompile")
    end,
  },
  { "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
  { "sam4llis/nvim-tundra", name = "tundra", lazy = true },
  -------------------------------------------------------------

  -- LSP and Autocomplete

  -- Make configuring the native LSP easy
  { "neovim/nvim-lspconfig" }, -- LSP Extensions
  { "simrat39/rust-tools.nvim" },
  { "p00f/clangd_extensions.nvim" },
  { "mfussenegger/nvim-jdtls" },
  { "b0o/schemastore.nvim" },
  -- Make configuring the natice LSP even easier
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  -- Provide nice vscode-like icons for autocomplete
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind-config")
    end,
  },
  -- autocomplete engine + completion source plugins
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("cmp-config")
    end,
  },

  --------------------------------------------------------------------------------
  -- Snippet engine + related plugins
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("snippets")
      end,
    },
  },
  -- Autocomplete/delete brackets and quotes
  {
    "windwp/nvim-autopairs",
    config = function()
      require("autopairs-config")
    end,
  }, -- Terminal Integration
  {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm-config")
    end,
  }, -- Navigation
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope-config")
    end,
    cmd = "Telescope",
  },
  -- Highly functional directory tree viewer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvimtree-config")
    end,
    cmd = "NvimTreeToggle",
  },
  -- Aggregate LSP provider - very ful for formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls-config")
    end,
  },
  -- VERY useful plugin for keymaps, especially multi-key keymaps
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key-config")
    end,
  },
  -- Modern vim-surround replacement which supports lua functions
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- Extend dot-repeat functionality to plugins
  { "tpope/vim-repeat" },
  -- Make extent vim motions e.g. c2ib to change in the *outer* bracket
  { "wellle/targets.vim" },
  -- Extend % functionality based on the language e.g. function() -> end in lua
  -- Also gives a nice highlight when hovering over pairs
  {
    "andymass/vim-matchup",
    config = function()
      require("matchup-config")
    end,
  },
  -- Zoom around the file
  -- ({ "ggandor/lightspeed.nvim" })
  -- Modern comment plugin which leverages Treesitter to do cool stuff like commenting out a function
  {
    "numToStr/Comment.nvim",
    config = function()
      require("comment-config")
    end,
  },
  -- Nice smooth scrolling  ctrl-d and ctrl-u etc.
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({ cursor_scrolls_alone = false })
    end,
  },
  -- Provide a good bit of vscode-style snippets, to be d with luasnip
  -- Show the context of the function/class at the top when you're in a long function
  { "nvim-treesitter/nvim-treesitter-context" },
  -- Project specific marks with a handy UI
  { "ThePrimeagen/harpoon" },
  -- Adds functionality to the quickfix list, such as a "magic window"
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({ func_map = { ptogglemode = "a" } })
    end,
  },
  -- Better bdelete and !bdelete
  { "moll/vim-bbye" },
  -- Neovim greeter
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha-config")
    end,
  },
  -- Gather all LSP diagnostics in one place
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },
  -- nvim-dap + related plugins
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap-config")
    end,
  },
  { "jayp0521/mason-nvim-dap.nvim" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui-config")
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end,
  },
  ----------------------------------------------------
  -- Nice loading spinner to indicate LSP startup progress (esp. for sumneko lua)
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({ text = { spinner = "dots" } })
    end,
  },
  -- Hydra.nvim stuff
  {
    "anuvyklack/hydra.nvim",
    config = function()
      require("hydra-config")
    end,
    keys = { "<leader>d", "<leader>g" },
  },
  -- Adds extra concealment for markdown files i.e. conceal links
  { "preservim/vim-markdown", ft = { "markdown" } },
  ---------------------------------- VERY useful multicursor plugin
  {
    "mg979/vim-visual-multi",
    config = function()
      require("vim-visual-multi-config")
    end,
  },
  -- Nice highlighting and icons for todos and notes etc.
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "WilsonOh/emoji_picker-nvim",
    config = function()
      require("emoji_picker").setup({})
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice-config")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    "mizlan/iswap.nvim",
    config = function()
      require("iswap").setup({
        autoswap = true,
        move_cursor = true,
        flash_style = false,
      })
    end,
  },
})
