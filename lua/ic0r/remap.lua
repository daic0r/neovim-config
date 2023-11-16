vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

-- Quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<M-o>", ":ClangdSwitchSourceHeader<CR>")

vim.keymap.set("n", "<leader>,", ":lua require('plenary.test_harness').test_file(vim.fn.expand('%:p'), { init = '~/.config/nvim/init.lua' })<CR>")
--vim.keymap.set("n", "<leader>,", "<Plug>PlenaryTestFile")
vim.keymap.set("n", "<S-left>", "<C-W><")
vim.keymap.set("n", "<S-right>", "<C-W>>")
vim.keymap.set("n", "<S-Up>", "<C-W>-")
vim.keymap.set("n", "<S-Down>", "<C-W>+")
