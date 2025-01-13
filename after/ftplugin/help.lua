vim.keymap.set("n", "q", function()
  vim.api.nvim_buf_delete(0, {})
end, { silent = true, buffer = 0 })
