return {
  {
    "rareitems/printer.nvim",
    config = function()
      require("printer").setup({
        keymap = "gp",
      })
    end,
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  "folke/neodev.nvim",
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
    event = "InsertEnter",
  },
  { "tpope/vim-repeat" },
  { "wellle/targets.vim" },
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
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({ cursor_scrolls_alone = false })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
  -- Project specific marks with a handy UI
  { "ThePrimeagen/harpoon", lazy = true },
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
  },
  { "preservim/vim-markdown", ft = { "markdown" } },
  "mg979/vim-visual-multi",
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
    lazy = true,
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  -- "sheerun/vim-polyglot",
}
