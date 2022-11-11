local function enable_transparent_mode()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_groups = {
        "Normal",
        "SignColumn",
        "NormalNC",
        "TelescopeBorder",
        "NvimTreeNormal",
        "EndOfBuffer",
        "MsgArea",
      }
      print("activated")
      for _, name in ipairs(hl_groups) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
  vim.opt.fillchars = "eob: "
end
_G.P = function(s)
  vim.pretty_print(s)
end

local api = vim.api

_G.test = function()
  P(api.nvim_get_current_line())
  -- api.nvim_put({ 'testing', 'lmao' }, '', true, true)
  api.nvim_set_current_line("lmao")
end

_G.set_colorscheme = function(colorscheme, transparent_bg)
  vim.cmd.packadd(colorscheme)
  pcall(require, "colorschemes." .. colorscheme)
  vim.cmd.colorscheme(colorscheme)

  if transparent_bg then
    local hl_groups = {
      "Normal",
      "SignColumn",
      "NormalNC",
      "TelescopeBorder",
      "NvimTreeNormal",
      "EndOfBuffer",
      "MsgArea",
    }
    for _, name in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
    end
  end
end

_G.get_char_at_cursor = function()
  return vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 1), 0, 1)
end

_G.get_word_under_cursor = function()
  local curr_reg = vim.fn.getreg("a")
  vim.api.nvim_cmd({ cmd = "normal!", args = { [["ayiw]] } }, {})
  local word = vim.fn.getreg("a")
  vim.fn.setreg("a", curr_reg)
  return word
end

_G.sub = function()
  local word = get_word_under_cursor()
  local cmd = "%s/" .. word .. "/" .. vim.fn.input({ prompt = "Enter the word to substitute: " }) .. "/g"
  vim.cmd(cmd)
end
