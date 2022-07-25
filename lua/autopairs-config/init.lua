require("nvim-autopairs").setup({
	break_line_filetype = nil,
	check_ts = true,
	enable_check_bracket_line = true,
	map_bs = true,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
