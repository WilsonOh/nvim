return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = "<M-j>",
          accept_line = "<M-l>",
          accept_word = "<M-k>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-c>",
        },
        panel = { enabled = false },
      },
      config = true,
      enabled = true,
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = true,
    enabled = false,
    dependencies = {
      "zbirenbaum/copilot.lua",
      "hrsh7th/nvim-cmp",
    },
  },
}
