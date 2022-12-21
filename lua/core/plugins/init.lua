return {
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
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufReadPre",
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
  -- Extend dot-repeat functionality to plugins
  { "tpope/vim-repeat" },
  -- Make extent vim motions e.g. c2ib to change in the *outer* bracket
  { "wellle/targets.vim" },
  -- Extend % functionality based on the language e.g. function() -> end in lua
  -- Also gives a nice highlight when hovering over pairs
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
  },
  -- Nice smooth scrolling  ctrl-d and ctrl-u etc.
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({ cursor_scrolls_alone = false })
    end,
  },
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
  -- "sheerun/vim-polyglot"
}
