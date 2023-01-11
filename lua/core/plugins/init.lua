return {
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
  "kyazdani42/nvim-web-devicons",
  "hrsh7th/cmp-nvim-lsp",
  "simrat39/rust-tools.nvim",
  "p00f/clangd_extensions.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "mfussenegger/nvim-jdtls",
  "b0o/schemastore.nvim",
  { "williamboman/mason.nvim" }, -- commit = "3ccd16" },
  "williamboman/mason-lspconfig.nvim",
  "jayp0521/mason-nvim-dap.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "nvim-lua/plenary.nvim",
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufReadPre",
  },
  -- "LudoPinelli/comment-box.nvim",
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
    cmd = "Neogen",
  },

  -----------------------------------------------------------

  -- Colorschemes
  { "rose-pine/neovim", name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
  { "catppuccin/nvim", name = "catppuccin", build = vim.cmd.CatppuccinCompile },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  { "sam4llis/nvim-tundra", name = "tundra" },
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
  -------------------------------------------------------------
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    keys = { "yss", "ys", "cs", "ds" },
  },

  {
    "karb94/neoscroll.nvim",

    config = function()
      require("neoscroll").setup({ cursor_scrolls_alone = false })
    end,
    lazy = false,
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
  -- Project specific marks with a handy UI
  { "ThePrimeagen/harpoon" },
  -- Adds functionality to the quickfix list, such as a "magic window"
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf", "Trouble" },
    config = function()
      require("bqf").setup({ func_map = { ptogglemode = "a" } })
    end,
  },
  -- Better bdelete and !bdelete
  { "moll/vim-bbye", lazy = false },
  -- Neovim greeter
  -- Gather all LSP diagnostics in one place
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({ text = { spinner = "dots" } })
    end,
    lazy = false,
  },
  { "preservim/vim-markdown", ft = { "markdown" } },
  { "mg979/vim-visual-multi", lazy = false },
  -- Nice highlighting and icons for todos and notes etc.
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
  },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  {
    "WilsonOh/emoji_picker-nvim",
    config = function()
      require("emoji_picker").setup({})
    end,
    cmd = "EmojiPicker",
  },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
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
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  -- "sheerun/vim-polyglot",
}
