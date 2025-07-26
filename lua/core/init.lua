-- General
require("core.options")
require("core.keybindings")
require("core.lazy")
require("core.lsp")

-- Souce all autocommands
require("autocmds")

-- Second optional parameter sets transparent background if true
require("utils").set_colorscheme("catppuccin")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    if vim.treesitter.get_parser(buf, ft, { error = false }) ~= nil then
      vim.treesitter.start()
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
      -- vim.o.foldtext = ''
      vim.o.fillchars = "fold: "
    end
  end,
})
