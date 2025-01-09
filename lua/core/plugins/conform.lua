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
  python = { "black" },
  ocaml = { "ocamlformat" },
  asm = { "asmfmt" },
}

for _, ft in ipairs(prettier_fts) do
  formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true }
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = formatters_by_ft,
    formatters = {
      ocamlformat = {
        command = "ocamlformat",
        args = { "--enable-outside-detected-project", "--name", "$FILENAME", "-" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
