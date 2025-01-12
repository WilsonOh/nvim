return {
  "saghen/blink.cmp",
  enabled = true,
  version = '*',
  opts_extend = {
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saghen/blink.compat",
    "echasnovski/mini.icons"
  },
  event = "InsertEnter",

  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "DressingInput", "TelescopePrompt" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
    end,
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = 'single',
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            }
          }
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'single' }
      },
      ghost_text = {
        enabled = false
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "single",
      }
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev", },
      cmdline = {},
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },


    keymap = {
      preset = "enter",
      ['<C-j>'] = { "show", "select_next", "fallback" },
      ['<C-k>'] = { "show", "select_prev", "fallback" },
      ['<C-e>'] = { "hide", "fallback" },
      ['<C-h>'] = { "snippet_backward" },
      ['<C-l>'] = { "snippet_forward" },
      ['<C-d>'] = { "scroll_documentation_down" },
      ['<C-f>'] = { "scroll_documentation_up" }
    },
  },
  config = function(_, opts)
    require('mini.icons').setup({
      lsp = {
        snippet = { glyph = '', hl = 'MiniIconsPurple' },
      }
    })
    require("blink.cmp").setup(opts)
  end,
}
