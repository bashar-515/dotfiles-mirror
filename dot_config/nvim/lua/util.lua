local M = {}

function M.invert_index(by_key)
  local by_value = {}
    for key, values in pairs(by_key) do
      for _, value in ipairs(values) do
        by_value[value] = by_value[value] or {}
        table.insert(by_value[value], key)
      end
    end
  return by_value
end

return M
