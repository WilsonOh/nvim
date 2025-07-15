local prettier_fts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

local formatters_by_ft = {
  fish = { "fish_indent" },
  lua = { "stylua" },
  python = { "ruff_format" },
  ocaml = { "ocamlformat" },
  asm = { "asmfmt" },
}

for _, ft in ipairs(prettier_fts) do
  formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true }
end

local format_on_save_excluded_fts = {
  "proto",
}

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = formatters_by_ft,
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if vim.tbl_contains(format_on_save_excluded_fts, ft) then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    --[[ formatters = {
      ocamlformat = {
        command = "ocamlformat",
        args = { "--enable-outside-detected-project", "--name", "$FILENAME", "-" },
      },
    }, ]]
  },
}
