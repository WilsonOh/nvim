local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.config = function()
  local actions = require("telescope.actions")
  local telescope = require("telescope")
  if telescope and actions then
    telescope.setup({
      defaults = {
        layout_config = {
          width = 0.75,
          prompt_position = "top",
          preview_cutoff = 120,
          horizontal = { mirror = false },
          vertical = { mirror = false },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "venv", "node_modules", "build", "dist", "yarn.lock", "package-lock.json" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {
          truncate = 3,
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<CR>"] = actions.select_default + actions.center,
            --[[ ["<C-d>"] = function(prompt_bufnr)
              local action_state = require("telescope.actions.state")
              local api = require("nvim-tree.api")
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              api.tree.find_file({
                buf = selection.cwd .. "/" .. selection.value,
                open = true,
                update_root = true,
                focus = true,
              })
            end, ]]
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
      },
      pickers = {
        find_files = { theme = "ivy", find_command = { "fd", "--type", "f", "--strip-cwd-prefix" } },
        git_files = { theme = "ivy", find_command = { "fd", "--type", "f", "--strip-cwd-prefix" } },
        colorscheme = { enable_preview = false },
      },
    })
    telescope.load_extension("fzf")
  end
end

return M
