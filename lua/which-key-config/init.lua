local mappings = {
	e = { ":NvimTreeToggle<cr>", "File Explorer" },
	f = {
		name = "Telescope",
		f = { ":Telescope find_files theme=ivy<CR>", "Find Files" },
		c = { ":Telescope find_files cwd=~/.config/nvim/ theme=ivy<CR>", "Search Config" },
		g = { ":Telescope git_files theme=ivy<CR>", "Search Git Files" },
		p = {
			function()
				require("telescope_utils").project_search()
			end,
			"Search Project",
		},
		r = { ":Telescope live_grep<CR>", "Live Grep" },
		b = { ":Telescope buffers bufnr=0<CR>", "Buffers" },
		o = { ":Telescope oldfiles<CR>", "Recent Files" },
		R = { ":Telescope resume<CR>", "Resume Previous Picker" },
		n = { ":Telescope neoclip<CR>", "Open Clipboard" },
	},
	t = {
		name = "Termimal",
		f = {
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local float = Terminal:new({ direction = "float" })
				return float:toggle()
			end,
			"Floating Terminal",
		},
		l = {
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
				return lazygit:toggle()
			end,
			"LazyGit",
		},
		r = {
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local ranger = Terminal:new({ cmd = "ranger", direction = "float" })
				return ranger:toggle()
			end,
			"Ranger",
		},
	},
	h = {
		name = "Harpoon",
		m = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Add Mark",
		},
		M = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"Toggle Quick Menu",
		},
		n = {
			function()
				require("harpoon.ui").nav_next()
			end,
			"Go To Next Mark",
		},
		["1"] = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			"Go To Mark 1",
		},
		["2"] = {
			function()
				require("harpoon.ui").nav_file(2)
			end,
			"Go To Mark 2",
		},
		["3"] = {
			function()
				require("harpoon.ui").nav_file(3)
			end,
			"Go To Mark 3",
		},
		["4"] = {
			function()
				require("harpoon.ui").nav_file(4)
			end,
			"Go To Mark 4",
		},
		p = {
			function()
				require("harpoon.ui").nav_prev()
			end,
			"Go To Previous Mark",
		},
	},
	l = {
		name = "LSP",
		i = { ":LspInfo<CR>", "Connected Language Servers" },
		k = { vim.lsp.buf.signature_help, "Signature help" },
		K = { vim.lsp.buf.hover, "Hover" },
		w = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
		W = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
		l = {
			"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
			"List workspace folder",
		},
		t = { vim.lsp.buf.type_definition, "Type definition" },
		d = { vim.lsp.buf.definition, "Go to definition" },
		r = { ":Trouble lsp_references<CR>", "References" },
		R = { vim.lsp.buf.rename, "Rename" },
		a = { vim.lsp.buf.code_action, "Code actions" },
		e = { vim.diagnostic.open_float, "Show line diagnostics" },
		n = { vim.diagnostic.goto_next, "Go to next diagnostic" },
		N = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
		I = { "<cmd>Mason<cr>", "Open Up Mason Package Manager" },
		f = {
			function()
				require("language-servers.utils").filtered_formatters(0)
			end,
			"Format File",
		},
		T = { ":Trouble<CR>", "Get Diagnostics" },
	},
	q = { ":copen<CR>", "Open QuickFix List" },
	a = { "ggVG", "Select Entire Buffer" },
	x = { ":Bdelete<cr>", "Close Buffer" },
	X = { ":Bdelete!<cr>", "Force Close Buffer" },
	p = {
		name = "Packer",
		r = { ":PackerClean<cr>", "Remove Unused Plugins" },
		c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
		i = { ":PackerInstall<cr>", "Install Plugins" },
		p = { ":PackerProfile<cr>", "Packer Profile" },
		s = { ":PackerSync<cr>", "Sync Plugins" },
		S = { ":PackerStatus<cr>", "Packer Status" },
		u = { ":PackerUpdate<cr>", "Update Plugins" },
	},
	z = {
		name = "Focus",
		z = { ":ZenMode<cr>", "Toggle Zen Mode" },
		t = { ":Twilight<cr>", "Toggle Twilight" },
	},
	b = {
		name = "Bufferline Options",
		c = { ":BufferLinePick<CR>", "Choose Buffer" },
		n = { ":BufferLineMoveNext<CR>", "Move buffer to the right" },
		p = { ":BufferLineMovePrev<CR>", "Move buffer to the left" },
	},
}

local opts = { prefix = "<leader>" }

require("which-key").register(mappings, opts)
