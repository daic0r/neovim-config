return {
   'simrat39/symbols-outline.nvim',
   config = function()
      require('symbols-outline').setup()

      vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<cr>', { noremap = true, silent = true })
   end
}
