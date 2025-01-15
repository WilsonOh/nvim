return {
  "andymass/vim-matchup",
  enabled = true,
  -- commit = "e2cca1747ab175b8d839a5d28679427564643a57",
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      group = vim.api.nvim_create_augroup("MatchupParen", { clear = true }),
      callback = function()
        -- vim.api.nvim_set_hl(0, "MatchParen", { bg = "#AA0044", bold = true, default = false })
        vim.g.matchup_matchparen_deferred = true
        vim.g.matchup_matchparen_hi_surround_always = true
      end,
    })
  end,
  lazy = false,
}
