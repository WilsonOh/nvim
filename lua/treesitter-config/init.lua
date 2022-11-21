require("nvim-treesitter.configs").setup({
  enabled = true,
  ensure_installed = "all", --{ "c", "cpp", "rust", "python", "java", "lua" },
  indent = { enable = false },
  highlight = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
  rainbow = { enable = true, extended_mode = false, disable = { "html" } },
  context_commentstring = { enable = true, enable_autocmd = false },
  --[[ textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  }, ]]
  textobjects = {
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
