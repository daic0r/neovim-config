local M = {}

local find_in_array = function(tbl, pred)
   for k,v in ipairs(tbl) do
      if pred(v) then
         return k,v
      end
   end
   return nil
end

local find_in_table = function(tbl, pred)
   for k,v in pairs(tbl) do
      if pred(k,v) then
         return k,v
      end
   end
   return nil
end

M.safe_set_keymap = function(mode, key, action, opts)
   local expandedkey = string.gsub(key, "<leader>", vim.g.mapleader)
   local keymap = vim.api.nvim_get_keymap(mode)
   assert(not find_in_array(keymap, function(val) return val.mode == mode and val.lhs == expandedkey end), "Keys '" .. key .. "' already mapped.")
   vim.keymap.set(mode, key, action, opts)
end

M.front = function(tbl)
   return pairs(tbl)(tbl)
end

return M
