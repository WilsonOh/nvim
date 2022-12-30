return {
  "andymass/vim-matchup",
  config = function()
    vim.api.nvim_create_augroup("MatchupParen", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "MatchParen", { bg = "#AA0044", bold = true, default = false })
        vim.g.matchup_matchparen_deferred = true
        vim.g.matchup_matchparen_hi_surround_always = true
      end,
    })
  end,
  lazy = false,
}
