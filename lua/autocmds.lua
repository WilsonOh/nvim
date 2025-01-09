-- local get_char_at_cursor = require("utils").get_char_at_cursor

-- vim.cmd(
--   [[autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=400}]]
-- )

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*.tsx", "*.js", "*.jsx" },
--   group = vim.api.nvim_create_augroup("jsx_self_closing_elements", { clear = true }),
--   callback = function()
--     vim.keymap.set("i", "/", function()
--       local ts_utils = require("nvim-treesitter.ts_utils")
--       local node = ts_utils.get_node_at_cursor()
--       while node and node:type() ~= "jsx_self_closing_element" do
--         node = node:parent()
--       end
--       if not node then
--         return "/"
--       end
--       if get_char_at_cursor() == " " then
--         return "/>"
--       else
--         return " />"
--       end
--     end, { expr = true, buffer = true })
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("HurlGroup", { clear = true }),
  pattern = "*.hurl",
  callback = function()
    vim.cmd.setfiletype("hurl")
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("QueryGroup", { clear = true }),
  pattern = "*/nvim/*/queries/*.scm",
  command = "set filetype=query",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("AsmFileType", { clear = true }),
  pattern = { "*.s", "*.asm" },
  command = "setlocal filetype=asm",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("MenhirFileType", { clear = true }),
  pattern = { "*.mly" },
  command = "setlocal filetype=menhir",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("OCamlLexFileType", { clear = true }),
  pattern = { "*.mll" },
  command = "setlocal filetype=ocamllex",
})
