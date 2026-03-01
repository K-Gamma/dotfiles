local M = {}

--- buffer-local な map ヘルパーを返す。desc に prefix を自動付与する。
--- シグネチャは vim.keymap.set と同じ (mode, keys, rhs, desc) で統一。
---@param bufnr integer
---@param prefix? string
---@return fun(mode: string|string[], keys: string, rhs: string|function, desc: string)
function M.buf_map(bufnr, prefix)
  return function(mode, keys, rhs, desc)
    vim.keymap.set(mode, keys, rhs, {
      buffer = bufnr,
      desc = prefix and (prefix .. ': ' .. desc) or desc,
    })
  end
end

return M
