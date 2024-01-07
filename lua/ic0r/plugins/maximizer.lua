return {
   'szw/vim-maximizer',
   config = function()
      vim.keymap.set('n', '<leader>mx', '<cmd>MaximizerToggle<cr>', { silent = true })
   end
}
