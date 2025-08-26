return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = false,
  branch = "main",
  enabled = true,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
    })

    local keymapGroups = {
      -- You can use the capture groups defined in textobjects.scm
      textobjects = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ag"] = "@comment.outer",
        ["ig"] = "@comment.inner",
        ["ac"] = "@class.outer",
        ["aj"] = "@jsx_attribute.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can also use captures from other query groups like `locals.scm`
      locals = {
        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      },
    }
    for group, keymaps in pairs(keymapGroups) do
      for key, query in pairs(keymaps) do
        vim.keymap.set({ "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, group)
        end)
      end
    end

    vim.keymap.set("n", "<c-l>", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end)
    vim.keymap.set("n", "<c-h>", function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
    end)

    -- move
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end)
  end,
}
