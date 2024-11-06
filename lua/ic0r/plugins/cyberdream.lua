return {
   "scottmckendry/cyberdream.nvim",
   lazy = true,
   priority = 1000,
   config = function()
      require('cyberdream').setup({
         transparent = true,
         borderless_telescope = false
      })
   end
}
