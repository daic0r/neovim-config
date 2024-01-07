return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   opts = {},
   config = function()
      require("ibl").setup({
         debounce = 2000,
      })
   end
}
