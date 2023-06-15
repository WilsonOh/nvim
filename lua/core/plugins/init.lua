return {
  { "f-person/git-blame.nvim", lazy = false },
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
    "kylechui/nvim-surround",
    config = true,
    keys = { "yss", "ys", "cs", "ds" },
  },
  {
    "karb94/neoscroll.nvim",
    opts = { cursor_scrolls_alone = false },
    event = "VeryLazy",
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
  -- Project specific marks with a handy UI
  { "ThePrimeagen/harpoon" },
  -- Adds functionality to the quickfix list, such as a "magic window"
  {
    "kevinhwang91/nvim-bqf",
    lazy = false,
    -- ft = { "qf", "Trouble" },
    -- opts = { func_map = { ptogglemode = "a" } },
  },
  -- Better bdelete and !bdelete
  { "moll/vim-bbye", lazy = false },
  -- Neovim greeter
  -- Gather all LSP diagnostics in one place
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    opts = { text = { spinner = "dots" } },
    event = "BufReadPre",
  },
  { "preservim/vim-markdown", ft = { "markdown" } },
  { "mg979/vim-visual-multi", lazy = false },
  -- Nice highlighting and icons for todos and notes etc.
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
  },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  {
    "mizlan/iswap.nvim",
    opts = {
      autoswap = true,
      move_cursor = true,
      flash_style = false,
    },
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "sheerun/vim-polyglot", lazy = false, enabled = true },
}
