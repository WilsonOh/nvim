local M = {
  "folke/which-key.nvim",
}

M.config = function()
  local mappings = {
    n = {
      l = {
        function()
          require("noice").cmd("last")
        end,
        "Noice Last Message",
      },
      h = {
        function()
          require("noice").cmd("history")
        end,
        "Noice History",
      },
      a = {
        function()
          require("noice").cmd("all")
        end,
        "Noice All",
      },
    },
    u = {
      function()
        vim.cmd("UndotreeToggle")
      end,
      "Toggle Undo Tree",
    },
    r = {
      name = "Run File",
      r = {
        function()
          require("utils").run_file(false, true)
        end,
        "Without Input",
      },
      f = {
        function()
          require("utils").run_file()
        end,
        "From File",
      },
      c = {
        function()
          require("utils").run_file(true)
        end,
        "From Clipboard",
      },
    },
    e = { ":NvimTreeToggle<cr>", "File Explorer" },
    f = {
      name = "Telescope",
      f = { ":Telescope find_files theme=ivy<CR>", "Find Files" },
      c = {
        function()
          require("core.plugins.telescope.utils").config_search()
        end,
        "Search Config",
      },
      p = {
        function()
          require("core.plugins.telescope.utils").project_search()
        end,
        "Search Project",
      },
      r = { ":Telescope live_grep<CR>", "Live Grep" },
      b = { ":Telescope buffers bufnr=0<CR>", "Buffers" },
      o = { ":Telescope oldfiles<CR>", "Recent Files" },
      R = { ":Telescope resume<CR>", "Resume Previous Picker" },
      m = {
        function()
          require("core.plugins.telescope.utils").custom_search()
        end,
        "Telescope Custom Search",
      },
      C = { ":Telescope current_buffer_fuzzy_find<CR>", "Current Buffer Fuzzy Find" },
    },
    t = {
      name = "Terminal",
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
    s = {
      function()
        vim.cmd.source()
        vim.notify("Current file has been sourced", vim.log.levels.INFO)
      end,
      "Source Current File",
    },
    S = {
      function()
        require("iswap").iswap_node_with()
      end,
      "Swap Nodes",
    },
    q = { ":copen<CR>", "Open QuickFix List" },
    a = { "ggVG", "Select Entire Buffer" },
    x = {
      function()
        vim.cmd("Bdelete")
      end,
      "Close Buffer",
    },
    w = {
      function()
        vim.cmd("Bdelete")
        local curr_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_close(curr_win, false)
      end,
      "Close Buffer and Window",
    },
    X = {
      function()
        vim.cmd("Bdelete!")
      end,
      "Force Close Buffer",
    },
    y = { ":%y+<CR>", "Copy Entire Buffer to System Clipboard" },
    p = {
      name = "Lazy Package Manager",
      r = { require("lazy").clean, "Remove Unused Plugins" },
      i = { require("lazy").install, "Install Plugins" },
      p = { require("lazy").profile, "Lazy Profile" },
      s = { require("lazy").sync, "Sync Plugins" },
      S = { require("lazy").home, "Lazy Home" },
      u = { require("lazy").update, "Update Plugins" },
    },
    b = {
      name = "Bufferline Options",
      c = { ":BufferLinePick<CR>", "Choose Buffer" },
      n = { ":BufferLineMoveNext<CR>", "Move buffer to the right" },
      p = { ":BufferLineMovePrev<CR>", "Move buffer to the left" },
    },
  }

  local opts = { prefix = "<leader>" }

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      local lsp_mappings = {
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
              require("language-servers.utils").format(0)
            end,
            "Format File",
          },
          T = { ":Trouble<CR>", "Get Diagnostics" },
        },
      }
      require("which-key").register(lsp_mappings, opts)
    end,
  })

  require("which-key").setup({
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,
    layout = {
      align = "center",
    },
  })

  require("which-key").register(mappings, opts)
end

return M
