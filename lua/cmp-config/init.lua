vim.o.completeopt = 'menu,menuone,noselect'

local luasnip = Vapour.utils.plugins.require('luasnip')
local cmp = Vapour.utils.plugins.require('cmp')
local lspkind = Vapour.utils.plugins.require('lspkind')

if not cmp or not luasnip or not lspkind then return end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
             :match '%s' == nil
end

local function get_sources()
  local sources = Vapour.plugins.lsp.cmp_sources
  table.insert(sources, { name = 'dictionary', keyword_length = 2 })
  return sources
end

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
    end
  end,
  preselect = cmp.PreselectMode.None,
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        path = '[Path]',
        dictionary = '[Dictionary]',
        emoji = '[Emoji]',
      },
    }),
    fields = { 'kind', 'abbr', 'menu' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
  confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
  window = { documentation = { border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } } },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    --[[ ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(), ]]
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = get_sources(),
})
vim.cmd(
    'autocmd FileType TelescopePrompt lua Vapour.utils.plugins.require(\'cmp\').setup.buffer { enabled = false }')

require('snippets')

--[[
cmp.setup.cmdline(':%s/', {
  view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }, { { name = 'fuzzy_buffer' } })
}) ]]
