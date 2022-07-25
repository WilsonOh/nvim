local Hydra = require("hydra")
local gitsigns = require("gitsigns")

local hint = [[
^                               Git Mode
^                              ----------
^ _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
^ _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
^ ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
^ ^
^ ^ ^                           _<Esc>_: exit
]]

Hydra({
	hint = hint,
	config = {
		color = "pink",
		invoke_on_body = true,
		hint = { position = "bottom", border = "rounded" },
		on_enter = function()
			vim.bo.modifiable = false
			gitsigns.toggle_signs(true)
			gitsigns.toggle_linehl(true)
		end,
		on_exit = function()
			gitsigns.toggle_signs(false)
			gitsigns.toggle_linehl(false)
			gitsigns.toggle_deleted(false)
			vim.cmd("echo") -- clear the echo area
		end,
	},
	mode = { "n", "x" },
	body = "<leader>g",
	heads = {
		{
			"J",
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end,
			{ expr = true },
		},
		{
			"K",
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end,
			{ expr = true },
		},
		{ "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
		{ "u", gitsigns.undo_stage_hunk },
		{ "S", gitsigns.stage_buffer },
		{ "p", gitsigns.preview_hunk },
		{ "d", gitsigns.toggle_deleted, { nowait = true } },
		{ "b", gitsigns.blame_line },
		{
			"B",
			function()
				gitsigns.blame_line({ full = true })
			end,
		},
		{ "/", gitsigns.show, { exit = true } }, -- show the base of the file
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

-- Hydra({
--   hint = [[
--  ^^^^^^     Move    ^^^^^^    ^^     Split         ^^^^    Size
--  ^^^^^^-------------^^^^^^    ^^---------------    ^^^^-------------
--  ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
--  _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
--  ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _q_: close           ^ _=_ ^: equalize
--  focus ^^^^^^  window
--  ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    _b_: choose buffer   ^ ^ ^ ^    _<Esc>_
-- ]],
--   config = { hint = { border = 'rounded' }, invoke_on_body = true },
--   mode = 'n',
--   body = '<leader>w',
--   heads = {
--     -- Move focus
--     { 'h', '<C-w>h' }, { 'j', '<C-w>j' }, { 'k', '<C-w>k' }, { 'l', '<C-w>l' }, -- Move window
--     { 'H', '<Cmd>WinShift left<CR>' }, { 'J', '<Cmd>WinShift down<CR>' },
--     { 'K', '<Cmd>WinShift up<CR>' }, { 'L', '<Cmd>WinShift right<CR>' }, -- Split
--     { 's', '<C-w>s' }, { 'v', '<C-w>v' },
--     { 'q', '<Cmd>try | close | catch | endtry<CR>', { desc = 'close window' } }, -- Size
--     { '+', '<C-w>+' }, { '-', '<C-w>-' }, { '>', '2<C-w>>', { desc = 'increase width' } },
--     { '<', '2<C-w><', { desc = 'decrease width' } }, { '=', '<C-w>=', { desc = 'equalize' } }, --
--     { 'b', '<Cmd>BufExplorer<CR>', { exit = true, desc = 'choose buffer' } },
--     { '<Esc>', nil, { exit = true } },
--   },
-- })

local dap = require("dap")

Hydra({
	name = "Debug",
	hint = [[
^                                    Debug Mode
^                                   ------------
^ _b_: Toggle Breakpoint            _c_: Continue        _S_: Step Into   _o_: Step Out
^ _B_: Toggle Condition Breakpoint  _s_: Step Over       _l_: Run Last    _r_: Repl Open 
^ _q_: Terminate Debugging Session  _R_: Run To Cursor
^ 
^                              _<Esc>_: Exit Debug Mode
]],
	config = { color = "pink", hint = { border = "rounded" }, invoke_on_body = true },
	mode = "n",
	body = "<leader>d",
	heads = {
		{ "b", dap.toggle_breakpoint },
		{
			"B",
			function()
				dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
			end,
		},
		{ "c", dap.continue },
		{ "s", dap.step_over },
		{ "S", dap.step_into },
		{ "o", dap.step_out },
		{ "l", dap.run_last },
		{ "r", dap.repl.toggle },
		{ "<Esc>", nil, { exit = true } },
		{ "q", dap.terminate },
		{ "R", dap.run_to_cursor },
	},
})
