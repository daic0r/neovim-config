vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--vim.keymap.set("n", "Y", "yg$")
--vim.keymap.set("n", "J", "mzJ`z")
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


vim.keymap.set("n", "<leader>,", ":lua require('plenary.test_harness').test_file(vim.fn.expand('%:p'), { init = '~/.config/nvim/init.lua' })<CR>")
--vim.keymap.set("n", "<leader>,", "<Plug>PlenaryTestFile")
vim.keymap.set("n", "<S-left>", "<C-W><")
vim.keymap.set("n", "<S-right>", "<C-W>>")
vim.keymap.set("n", "<S-Up>", "<C-W>-")
vim.keymap.set("n", "<S-Down>", "<C-W>+")

vim.keymap.set("n", "<leader>\\", function()
    -- Get row and column cursor,
    -- use unpack because it's a tuple.
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local uuid, _ = vim.fn.system("uuidgen"):gsub("\n", "")
    -- Notice the uuid is given as an array parameter, you can pass multiple strings.
    -- Params 2-5 are for start and end of row and columns.
    -- See earlier docs for param clarification or `:help nvim_buf_set_text.
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { uuid })
end)

-- Find in files and open quickfix list
local find_in_files = function(what, ask_extension)
   local ext = "*/**/"
   if ask_extension then
      vim.ui.input({
         prompt = "Search which files?",
         default = "*",
      },
      function(input)
         if not input then
            return
         end
         ext = ext .. input
         vim.cmd("vimgrep /" .. vim.fn.expand("<c" .. what .. ">") .. "/gj " .. ext)
         vim.cmd("copen")
      end)
   else
      ext = ext .. "*"
      vim.cmd("vimgrep /" .. vim.fn.expand("<c" .. what .. ">") .. "/gj " .. ext)
      vim.cmd("copen")
   end
end

vim.keymap.set("n", "<leader>sf", function()
   find_in_files("word", false)
end)
vim.keymap.set("n", "<leader>sfW", function()
   find_in_files("WORD", false)
end)
vim.keymap.set("n", "<leader>sfp", function()
   find_in_files("word", true)
end)
vim.keymap.set("n", "<leader>sfpW", function()
   find_in_files("WORD", true)
end)
