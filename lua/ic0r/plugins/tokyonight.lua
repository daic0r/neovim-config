return {
   "folke/tokyonight.nvim",
   lazy = true,
   priority = 1000,
   opts = {},
   config = function()
      require("tokyonight").setup({
         style = "night",
         transparent = true,
         styles = {
            sidebars = "transparent",
            floats = "transparent"
         }
      })
   end,
}
