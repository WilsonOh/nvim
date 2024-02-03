local Job = require("plenary.job")

local function runFormatter(text)
  local binPath = vim.fn.stdpath("config") .. "/bin"
  local formatterPath = binPath .. "/formatJsdocYaml.py"
  return Job:new({
    command = "python",
    args = { formatterPath },
    writer = { text },
  }):sync()
end

local function formatSwaggerDocsYaml()
  local query = vim.treesitter.query.parse(
    "typescript",
    [[
 ((comment) @swagger_comment
             (#contains? @swagger_comment "@swagger"))
  ]]
  )

  local parser = vim.treesitter.get_parser(0, "typescript", {})
  local tree = parser:parse()[1]:root()

  local changes = {}
  for id, node in query:iter_captures(tree, 0, 0, -1) do
    local name = query.captures[id]
    if name == "swagger_comment" then
      local node_text = vim.treesitter.get_node_text(node, 0)
      local range = { node:range() }
      local formatted, code = runFormatter(node_text)
      if code ~= 0 then
        vim.notify("Error formatting yaml", vim.log.levels.WARN)
        break
      end
      table.insert(changes, 1, {
        start = range[1],
        final = range[3] + 1,
        formatted = formatted,
      })
    end
  end
  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(0, change.start, change.final, false, change.formatted)
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("JsdocsFormatter", { clear = true }),
  pattern = "*.ts",
  callback = formatSwaggerDocsYaml,
})

vim.api.nvim_create_user_command("FormatSwaggerYaml", formatSwaggerDocsYaml, {})
