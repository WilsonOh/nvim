local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",

  dependencies = {
    "p00f/nvim-ts-rainbow",
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/nvim-treesitter-textobjects",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    enabled = true,
    ensure_installed = {
      "cpp",
      "c",
      "lua",
      "rust",
      "python",
      "javascript",
      "typescript",
      "json",
      "html",
      "css",
      "java",
    },
    indent = { enable = false },
    highlight = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
    rainbow = { enable = false, extended_mode = false, disable = { "html" } },
    context_commentstring = { enable = true, enable_autocmd = false },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["iC"] = "@conditional.inner",
          ["aC"] = "@conditional.outer",
          ["ag"] = "@comment.outer",
          ["il"] = "@call.inner",
          ["al"] = "@call.outer",
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  })
end

return M
