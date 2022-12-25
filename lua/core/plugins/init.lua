return {
  "kyazdani42/nvim-web-devicons",
  "hrsh7th/cmp-nvim-lsp",
  "simrat39/rust-tools.nvim",
  "p00f/clangd_extensions.nvim",
  "mfussenegger/nvim-jdtls",
  "b0o/schemastore.nvim",
  { "williamboman/mason.nvim", commit = "3ccd16" },
  "williamboman/mason-lspconfig.nvim",
  "jayp0521/mason-nvim-dap.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "andymass/vim-matchup",
    config = function()
      vim.api.nvim_create_augroup("MatchupParen", {})
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "MatchParen", { bg = "#AA0044", bold = true, default = false })
          vim.g.matchup_matchparen_deferred = true
          vim.g.matchup_matchparen_hi_surround_always = true
        end,
      })
    end,
    lazy = false,
  },
  { "tpope/vim-repeat", lazy = false },
  { "wellle/targets.vim", lazy = false },
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
    event = "BufReadPre",
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufReadPre",
  },
  "LudoPinelli/comment-box.nvim",

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
    cmd = "SymbolsOutline",
  },

  -----------------------------------------------------------

  -- Colorschemes
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "ellisonleao/gruvbox.nvim", name = "gruvbox", lazy = true },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    build = function()
      pcall(vim.cmd, "CatppuccinCompile")
    end,
    lazy = true,
  },
  { "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
  { "sam4llis/nvim-tundra", name = "tundra", lazy = true },
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon", lazy = true },
  -------------------------------------------------------------
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
    keys = { "s", "S" },
  },
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
    ft = "qf",
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
    dependencies = "kyazdani42/nvim-web-devicons",
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
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  {
    "WilsonOh/emoji_picker-nvim",
    config = function()
      require("emoji_picker").setup({})
    end,
    cmd = "EmojiPicker",
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", cmd = { "DiffviewOpen" } },
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
