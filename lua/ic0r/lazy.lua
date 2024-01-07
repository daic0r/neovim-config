local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/playground',
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
      {
         'daic0r/rust-tdd',
         config = function()
            require('rust-tdd').setup()
         end
      },
      -- Copilot
      'github/copilot.vim',
      'tpope/vim-surround',
      {
         dir = "~/programming/neovim/plugins/dap-helper",
         config = function()
            require("dap-helper").setup()
         end,
         dev = true
      },
      {
         import = "ic0r.plugins"
      }
      --[[
   {
      'daic0r/dap-helper.nvim',
      dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
   }
   --]]
      --[[
   {
      "m4xshen/hardtime.nvim",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      config = function()
         require("hardtime").setup()
      end,
      opts = {}
   },
   --]]

   },
   {
      install = {
         colorscheme = { "rosepine" },
      },
      checker = {
         enable = true,
         notify = false
      },
      change_detection = {
         enabled = true,
         notify = false
      },
      dev = {
        -- directory where you store your local plugin projects
        path = "~/programming/neovim/plugins",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {"daic0r"}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
      },
   })
