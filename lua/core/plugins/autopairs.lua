local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
}

M.config = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
  })

  local Rule = require("nvim-autopairs.rule")

  local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
  npairs.add_rules({
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2],
      }, pair)
    end),
    Rule("/*", "*/", { "c", "cpp" }),
  })

  for _, bracket in pairs(brackets) do
    npairs.add_rules({
      Rule(bracket[1] .. " ", " " .. bracket[2])
        :with_pair(function()
          return false
        end)
        :with_move(function(opts)
          return opts.prev_char:match(".%" .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2]),
    })
  end
end

return M
