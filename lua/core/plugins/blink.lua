local disabled_filetypes = { "DressingInput", "TelescopePrompt", "snacks_picker_input" }
return {
  "saghen/blink.cmp",
  enabled = true,
  version = "*",
  opts_extend = {
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "saghen/blink.compat",
    "echasnovski/mini.icons",
  },
  event = "InsertEnter",

  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    cmdline = {
      enabled = false,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
        border = "single",
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "single" },
      },
      ghost_text = {
        enabled = false,
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "single",
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        cmdline = {
          enabled = false,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-j>"] = { "show", "select_next", "fallback" },
      ["<C-k>"] = { "show", "select_prev", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down" },
      ["<C-f>"] = { "scroll_documentation_up" },
    },
  },
  config = function(_, opts)
    require("mini.icons").setup({
      lsp = {
        snippet = { glyph = "", hl = "MiniIconsPurple" },
        ["function"] = { glyph = "󰡱" },
        variable = { glyph = "󰀫" },
      },
    })
    require("blink.cmp").setup(opts)
  end,
}
