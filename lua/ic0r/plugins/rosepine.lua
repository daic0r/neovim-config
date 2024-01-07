return {
   'rose-pine/neovim',
   name = 'rose-pine',
   priotity = 1000,
   config = function()
      require('rose-pine').setup({
         disable_background = true,
         disable_float_background = true,
         disable_italics = true,
      })
      vim.cmd.colorscheme("rose-pine")
   end
}
