local M = {
   "theprimeagen/harpoon"
}

M.config = function()
   local mark = require("harpoon.mark")
   local ui = require("harpoon.ui")
   local harpoon = require("harpoon")

   harpoon.setup()

   vim.keymap.set("n", "<leader>a", mark.add_file)
   vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

   vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
   vim.keymap.set("n", "<C-g>", function() ui.nav_file(2) end)
   vim.keymap.set("n", "<C-v>", function() ui.nav_file(3) end)
   vim.keymap.set("n", "<C-n>", function() ui.nav_file(4) end)
end

return M
