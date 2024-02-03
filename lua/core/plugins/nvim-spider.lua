local keys_to_use = { "w", "e", "b" }
local keys = {}

for _, key in ipairs(keys_to_use) do
  table.insert(keys, {
    "," .. key,
    function()
      require("spider").motion(key)
    end,
    mode = { "n", "x", "o" },
  })
end

return {
  "chrisgrieser/nvim-spider",
  keys = keys,
  opts = {
    skipInsignificantPunctuation = false,
  },
}
