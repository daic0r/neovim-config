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
    {
	    'nvim-telescope/telescope.nvim', tag = '0.1.3',
	    -- or                              , branch = '0.1.x',
	    dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
	    "folke/tokyonight.nvim",
	    lazy = false,
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
         vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			vim.cmd.TSUpdate()
		end
	},
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
   },
	'nvim-treesitter/playground',
	'theprimeagen/harpoon',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{'williamboman/mason-lspconfig.nvim'},
   -- Autocompletion for neovim lua!
   {
      "folke/neodev.nvim",
      config = function()
         require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true },
         })
      end
   },
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
   {
      'hrsh7th/nvim-cmp',
      event = "InsertEnter",
      dependencies = {
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-path',
         'saadparwaiz1/cmp_luasnip',
         'rafamadriz/friendly-snippets',
         'L3MON4D3/LuaSnip',
      }
   },
	{'L3MON4D3/LuaSnip'},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
      config = function()
         require("ibl").setup({
            debounce = 2000,
         })
      end
   },
   'mfussenegger/nvim-dap',
   {
      'rcarriga/nvim-dap-ui',
   },
   {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
         require('nvim-dap-virtual-text').setup()
      end
   },
   'simrat39/rust-tools.nvim',
   {
      'daic0r/rust-tdd',
      config = function()
         require('rust-tdd').setup()
      end
   },
   -- Copilot
   'github/copilot.vim',
   {
      'simrat39/symbols-outline.nvim',
      config = function()
	      require('symbols-outline').setup()
      end
   },
   {
      "nvim-tree/nvim-tree.lua",
      dependencies = "nvim-tree/nvim-web-devicons",
   },
   'voldikss/vim-floaterm',
   {
     'stevearc/dressing.nvim',
     lazy = true,
     opts = {},
     event = "VeryLazy"
   },
   'tpope/vim-surround',
   {
      'christoomey/vim-tmux-navigator'
   },
   {
      dir = "~/programming/neovim/plugins/dap-helper",
      config = function()
         require("dap-helper").setup()
      end,
   },
   --[[
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
         require("catppuccin").setup({
            transparent_background = true
         })
      end
   }
   --]]
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
      colorscheme =  {"tokyonight" },
   },
   checker = {
      enable = true,
      notify = false
   },
   change_detection = {
      notify = false
   }
})
