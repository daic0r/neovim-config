local M = {
   'nvim-telescope/telescope.nvim',
   -- or                              , branch = '0.1.x',
   dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
   local builtin = require('telescope.builtin')
   vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
   vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
   vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
   vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
   vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})
   vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
   vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})

   -- Git
   vim.keymap.set('n', '<leader>gf', builtin.git_files, {})

   vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep> ") })
   end)
end

return M
