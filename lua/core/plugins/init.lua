return {
  { "abecodes/tabout.nvim", config = true, event = "InsertEnter" },
  { "f-person/git-blame.nvim", cmd = "GitBlameEnable" },
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
  "kyazdani42/nvim-web-devicons",
  -- "simrat39/rust-tools.nvim",
  -- "p00f/clangd_extensions.nvim",
  -- "jose-elias-alvarez/typescript.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "nvim-lua/plenary.nvim",
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    event = "BufReadPre",
  },
  -- "LudoPinelli/comment-box.nvim",
  {
    "danymat/neogen",
    opts = { snippet_engine = "luasnip" },
    cmd = "Neogen",
  },

  -----------------------------------------------------------

  -- Colorschemes
  { "rose-pine/neovim", name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
  { "catppuccin/nvim", name = "catppuccin", build = ":CatppuccinCompile" },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  { "sam4llis/nvim-tundra", name = "tundra" },
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
  -------------------------------------------------------------
  {
    "karb94/neoscroll.nvim",
    opts = { cursor_scrolls_alone = false },
    event = "VeryLazy",
  },
  -- Project specific marks with a handy UI
  { "ThePrimeagen/harpoon" },
  -- Gather all LSP diagnostics in one place
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    config = true,
    -- tag = "legacy",
    event = "BufReadPre",
  },
  { "preservim/vim-markdown", ft = { "markdown" } },
  {
    "folke/todo-comments.nvim",
    config = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
  },
  {
    "WilsonOh/emoji_picker-nvim",
    config = true,
    cmd = "EmojiPicker",
    keys = { { mode = "i", "<M-e>", "<cmd>EmojiPicker<cr>", desc = "Open EmojiPicker" } },
  },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  {
    "mizlan/iswap.nvim",
    opts = {
      autoswap = true,
      move_cursor = true,
      flash_style = false,
    },
    keys = {
      {
        "S",
        function()
          require("iswap").iswap_node_with()
        end,
        desc = "Swap Nodes",
      },
    },
  },
  { "sheerun/vim-polyglot", lazy = false, enabled = true },
}
