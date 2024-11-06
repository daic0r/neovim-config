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
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      'hrsh7th/cmp-nvim-lua',
      {
         "hrsh7th/cmp-cmdline",
         enable = true,
      },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      {
         'L3MON4D3/LuaSnip',
         dependencies = {
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
         },
         config = function()
            require('luasnip.loaders.from_vscode').lazy_load({
               paths = {
                  vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
                  -- my snippets
                  vim.fn.stdpath("config") .. "/snippets"
               }
            })
         end,
         build = "make install_jsregexp",
         event = "InsertEnter",
      },
      -- {
      --    'daic0r/rust-tdd',
      --    config = function()
      --       require('rust-tdd').setup()
      --    end
      -- },
      -- Copilot
      'github/copilot.vim',
      'tpope/vim-surround',
      { "nvim-neotest/nvim-nio" },
      {
         dir = "~/programming/neovim/plugins/hashtags/",
         config = function()
            local hashtags = require('hashtags')
            hashtags.setup()
            vim.keymap.set('n', '<leader>hn', hashtags.nav_next)
            vim.keymap.set('n', '<leader>hp', hashtags.nav_prev)
            vim.keymap.set('n', '<leader>hs', hashtags.show_ui)
         end,
         dependencies = { "nvim-lua/plenary.nvim" },
         dev = true
      },
      -- {
      --    dir = "~/programming/neovim/plugins/dap-helper",
      --    config = function()
      --       require("dap-helper").setup()
      --    end,
      --    dev = true
      -- },
      -- {
      --    dir = "~/programming/neovim/plugins/forget_me_not",
      --    config = function()
      --       require("forget_me_not"):setup()
      --    end,
      --    dev = true
      -- },
      {
         import = "ic0r.plugins"
      },
   {
      'daic0r/dap-helper.nvim',
      dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
   }
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
         colorscheme = { "catpuccin", "tokyonight", "rosepine" },
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
         patterns = { "daic0r" }, -- For example {"folke"}
         fallback = false,     -- Fallback to git when local plugin doesn't exist
      },
   })
