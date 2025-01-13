local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
      "xzbdmw/colorful-menu.nvim",
      config = function()
        require("colorful-menu").setup({})
      end,
    },
  },
  enabled = false,
}

M.config = function()
  local f = require("core.plugins.cmp.format")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  vim.o.completeopt = "menu,menuone,noselect"

  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp_sources = {
    { name = "nvim_lsp", priority = 100 },
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
        return false
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
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    performance = {
      debounce = 0,
      throttle = 0,
      fetching_timeout = 20000,
      confirm_resolve_timeout = 1,
      async_budget = 1,
      max_view_entries = 100,
    },
    -- formatting = {
    --   format = lspkind.cmp_format({
    --     mode = "symbol_text",
    --     maxwidth = 50,
    --     menu = {
    --       buffer = "[Buffer]",
    --       nvim_lsp = "[LSP]",
    --       luasnip = "[LuaSnip]",
    --       path = "[Path]",
    --       dictionary = "[Dictionary]",
    --       emoji = "[Emoji]",
    --     },
    --   }),
    --   fields = { "kind", "abbr", "menu" },
    --   expandable_indicator = true
    -- },
    formatting = {
      -- kind is icon, abbr is completion name, menu is [Function]
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local highlights_info = require("colorful-menu").cmp_highlights(entry)
        if highlights_info ~= nil then
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end
        local function commom_format(e, item)
          local kind = lspkind.cmp_format({
            mode = "symbol_text",
            -- show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          })(e, item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = ""
          kind.concat = kind.abbr
          return kind
        end
        if vim.bo.filetype == "rust" then
          return f.rust_fmt(entry, vim_item)
        elseif vim.bo.filetype == "lua" then
          return f.lua_fmt(entry, vim_item)
        elseif vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
          return f.cpp_fmt(entry, vim_item)
        elseif vim.bo.filetype == "go" then
          return f.go_fmt(entry, vim_item)
        else
          return commom_format(entry, vim_item)
        end
      end,
      expandable_indicator = true,
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
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- elseif luasnip.expandable() then
          --   luasnip.expand()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function(fallback)
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
