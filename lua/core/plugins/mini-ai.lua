return {
  "echasnovski/mini.ai",
  lazy = false,
  opts = function()
    local ai = require("mini.ai")

    return {
      --[[ n_lines = 500,
      custom_textobjects = {
        -- a = ai.gen_spec.treesitter({
        --   a = { "@parameter.outer" },
        --   i = { "@parameter.inner" },
        -- }),
        j = ai.gen_spec.treesitter({
          a = { "@jsx_attribute.outer" },
          i = { "@jsx_attribute.inner" },
        }),
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer", "@call.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner", "@call.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        g = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
      }, ]]
    }
  end,
  config = function(_, opts)
    local ai = require("mini.ai")
    ai.setup(opts)
  end,
}
