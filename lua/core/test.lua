local bufnr = vim.api.nvim_get_current_buf()
local lang = vim.bo.filetype
local q = vim.treesitter

local lt = vim.treesitter.get_parser(bufnr, lang)
local root = lt:parse()[1]:root()
local ts_utils = require('nvim-treesitter.ts_utils')

local cur_node = ts_utils.get_node_at_cursor()

if not cur_node then return end

if cur_node:type() ~= 'identifier' then return end

while (cur_node and cur_node:type() ~= 'function_call') do cur_node = cur_node:parent() end

if cur_node then P(cur_node:type()) end

-- local comment_query = vim.treesitter.parse_query(lang, [[
-- (comment) @comment
-- ]])
--
-- print('The comments in this file are: ')
-- for _, captures, _ in comment_query:iter_matches(root, bufnr) do
--   for _, capture in ipairs(captures) do
--     local comment = ts_query.get_node_text(capture, bufnr)
--     local comment_text = comment:sub(4)
--     print(comment_text)
--   end
-- end
--
-- local require_query = vim.treesitter.parse_query(lang, [[
-- (function_call
--   name: (identifier) @function (#eq? @function "require")
--   arguments: (arguments) @args)
-- ]])
--
-- print('The functions called are:')
-- for _, captures, _ in require_query:iter_matches(root, bufnr) do
--   for _, capture in ipairs(captures) do
--     local req = ts_query.get_node_text(capture, bufnr)
--     print(req)
--   end
-- end
--
-- local binary_exp_query = vim.treesitter.parse_query(lang, [[
-- ((binary_expression right: (identifier))) @bin_exp
-- ]])
--
-- print('Binary exps are: \n')
-- for _, captures, _ in binary_exp_query:iter_matches(root, bufnr) do
--   for _, capture in ipairs(captures) do
--     local bin = ts_query.get_node_text(capture, bufnr)
--     print(bin)
--   end
-- end
