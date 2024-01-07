local M = {
   "nvim-tree/nvim-tree.lua",
   dependencies = "nvim-tree/nvim-web-devicons",
}

M.config = function()
   -- disable netrw at the very start of your init.lua
   vim.g.loaded_netrw = 1
   vim.g.loaded_netrwPlugin = 1

   -- empty setup using defaults
   --require("nvim-tree").setup()

   -- OR setup with some options
   require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
         width = 30,
      },
      renderer = {
         group_empty = true,
      },
      filters = {
         dotfiles = false,
      },
   })

   vim.keymap.set('n', '<leader>ee', '<Cmd>NvimTreeToggle<CR>')
   vim.keymap.set('n', '<leader>ef', '<Cmd>NvimTreeFindFile<CR>')
end

return M
