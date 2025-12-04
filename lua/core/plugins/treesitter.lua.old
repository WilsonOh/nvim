return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ag"] = "@comment.outer",
            ["ig"] = "@comment.inner",
            ["aj"] = "@jsx_attribute.outer",
          },
          --[[ selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          }, ]]
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<C-l>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<C-h>"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
          },
        },
      },
    })
  end,
}
