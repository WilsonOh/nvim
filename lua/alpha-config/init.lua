local present, alpha = pcall(require, 'alpha')
if not present then return end

local dashboard = require('alpha.themes.dashboard')

-- ╭──────────────────────────────────────────────────────────╮
-- │ Header                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local header = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}

vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#1b63a6', bold = true })
vim.api.nvim_set_hl(0, 'AlphaInfo', { fg = '#8aa61b', bold = true })

dashboard.section.header.type = 'text';
dashboard.section.header.val = header;
dashboard.section.header.opts = { position = 'center', hl = 'AlphaHeader' }

-- ╭──────────────────────────────────────────────────────────╮
-- │ Heading Info                                             │
-- ╰──────────────────────────────────────────────────────────╯

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then return end
local date = thingy:read('*a')
thingy:close()

local datetime = os.date ' %H:%M'

local hi_top_section = {
  type = 'text',
  val = '┌────────────   Today is ' .. date
      .. ' ────────────┐',
  opts = { position = 'center', hl = 'AlphaInfo' },
}

local hi_middle_section = {
  type = 'text',
  val = '│                                                │',
  opts = { position = 'center', hl = 'AlphaInfo' },
}

local hi_bottom_section = {
  type = 'text',
  val = '└───══───══───══───  ' .. datetime
      .. '  ───══───══───══────┘',
  opts = { position = 'center', hl = 'AlphaInfo' },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Buttons                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Copied from Alpha.nvim source code

local map_opts = { silent = true }
dashboard.section.buttons.val = {
  dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>', map_opts),
  dashboard.button('f', '  > Find file', ':Telescope find_files<CR>', map_opts),
  dashboard.button('c', '  > Search Configs',
                   ':Telescope find_files cwd=~/.config/nvim/lua/<CR>', map_opts),
  dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>', map_opts),
  dashboard.button('s', '  > Settings', ':e ~/.config/nvim/lua/core/init.lua<CR>', map_opts),
  dashboard.button('q', '  > Quit NVIM', ':qa<CR>', map_opts),
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Footer                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local function footer()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  return string.format(' v%d.%d.%d   %d', v.major, v.minor, v.patch, plugins)
end

dashboard.section.footer.val = { footer() }
dashboard.section.footer.opts = { position = 'center', hl = 'AlphaInfo' }

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}

local opts = {
  layout = {
    { type = 'padding', val = 5 }, section.header, { type = 'padding', val = 1 },
    section.hi_top_section, section.hi_middle_section, section.hi_bottom_section,
    { type = 'padding', val = 2 }, section.buttons, --[[ { type = 'padding', val = 5 } ]]
    section.footer,
  },
  opts = { margin = 5 },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯

alpha.setup(opts)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Hide tabline and statusline on startup screen            │
-- ╰──────────────────────────────────────────────────────────╯
vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  command = 'set showtabline=0 noruler',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  callback = function()
    vim.api.nvim_create_autocmd('BufUnload', {
      group = 'alpha_tabline',
      buffer = 0,
      command = 'set showtabline=2 ruler',
    })
  end,
})
