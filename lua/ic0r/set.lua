vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME")
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.iskeyword:append("-")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.wildignore:append("node_modules/")

vim.opt.cursorline = true
vim.opt.guicursor = ""

vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
   pattern = "*",
   callback = function(opts)
      vim.highlight.on_yank({
         higroup = "IncSearch",
         timeout = 200,
         on_visual = true,
         virt_text_pos = "overlay",
         virt_text = "Yanked",
      })
   end
})
