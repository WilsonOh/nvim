local M = {
  "numToStr/Comment.nvim",
  keys = {
    "gb",
    "gc",
    "gcc",
    "gbc",
    { "gb", mode = "x" },
    { "gc", mode = "x" },
  },
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        vim.g.skip_ts_context_commentstring_module = true
        require("ts_context_commentstring").setup()
      end,
    },
  },
}

function M.config()
  require("Comment").setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
