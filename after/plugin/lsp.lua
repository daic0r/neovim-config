local lsp_zero = require("lsp-zero")

lsp_zero.setup_servers({ "clangd", "lua_ls", "rust_analyzer" })

--[[
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)
--]]

-- Enables recogonizition of built-in Neovim symbols
--[[
require'lspconfig'.lua_ls.setup {
   on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
         client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
               runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
               },
               -- Make the server aware of Neovim runtime files
               workspace = {
                  checkThirdParty = false,
                  library = {
                     vim.env.VIMRUNTIME
                     -- "${3rd}/luv/library"
                     -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
               }
            }
         })

         client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
   end
}
--]]
--lsp_zero.setup()
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "clangd", "lua_ls", "rust_analyzer" },
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
  },
})
--
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior, count = 1 }
local cmp_mappings = cmp.mapping.preset.insert({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
   ['<C-Down>'] = function()
      print("scroll")
      cmp.mapping.scroll_docs(-4)
   end,
   ['<C-Up>'] = cmp.mapping.scroll_docs(4),
   ['<C-e>'] = cmp.mapping.abort(),
   ['<CR>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end)

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = true
})
