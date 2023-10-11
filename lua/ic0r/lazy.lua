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
		    vim.cmd.colorscheme('tokyonight-night')
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
      event = "InsertEnter"
   },
	{'L3MON4D3/LuaSnip'},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
   --[[
   { "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
      config = function()
         require("ibl").setup({
            debounce = 2000,
         })
      end
   },
   --]]
   'mfussenegger/nvim-dap',
   {
      'rcarriga/nvim-dap-ui',
   },
   {
      'theHamsta/nvim-dap-virtual-text',
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

}, opts)
