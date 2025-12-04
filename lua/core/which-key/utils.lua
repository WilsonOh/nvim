local M = {}

--- @class FormatOpts
--- @field prefix string

--- @param format_opts FormatOpts
M.format_keymaps = function(mappings, format_opts, map_opts)
  local prefix = format_opts.prefix
  return vim
    .iter(mappings)
    :map(function(keymap)
      local new_mapping = {
        prefix .. keymap[1],
        keymap[2],
        desc = keymap[3],
        mode = keymap[4],
      }
      return vim.tbl_deep_extend("force", new_mapping, map_opts)
    end)
    :totable()
end

return M
