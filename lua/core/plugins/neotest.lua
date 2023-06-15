return {
  "nvim-neotest/neotest",
  dependencies = {
    "haydenmeade/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npx jest",
        }),
      },
    })
  end,
}
