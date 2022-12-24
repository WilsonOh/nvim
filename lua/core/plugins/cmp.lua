local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
}

M.config = function()
  vim.o.completeopt = "menu,menuone,noselect"

  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp_sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
    { name = "dictionary", keyword_length = 2 },
  }

  cmp.setup({
    enabled = function()
      -- disable if in telescope
      if vim.bo.filetype == "TelescopePrompt" then
        return
      end
      -- disable completion in comments
      local context = require("cmp.config.context")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
          dictionary = "[Dictionary]",
          emoji = "[Emoji]",
        },
      }),
      fields = { "kind", "abbr", "menu" },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    view = { entries = { name = "custom", selection_order = "near_cursor" } },
    window = { documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } } },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp_sources,
  })
end

return M
