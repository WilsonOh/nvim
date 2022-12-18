vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.tsx", "*.js", "*.jsx" },
  group = vim.api.nvim_create_augroup("jsx_self_closing_elements", { clear = true }),
  callback = function()
    vim.keymap.set("i", "/", function()
      local ts_utils = require("nvim-treesitter.ts_utils")
      local node = ts_utils.get_node_at_cursor()
      while node and node:type() ~= "jsx_self_closing_element" do
        node = node:parent()
      end
      if not node then
        return "/"
      end
      if require("globals").get_char_at_cursor() == " " then
        return "/>"
      else
        return " />"
      end
    end, { expr = true, buffer = true })
  end,
})
