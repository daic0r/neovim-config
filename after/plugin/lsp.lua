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
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {
   settings = {
      Lua = {
         workspace = {
            checkThirdParty = false,
               library = {
                 [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                 [vim.fn.stdpath("config") .. "/lua"] = true,
            },
         }
      }
   }
   --[[
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
   --]]
}

 -- configure html server
 lspconfig["html"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
 })

 -- configure typescript server with plugin
 lspconfig["tsserver"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
 })

 -- configure css server
 lspconfig["cssls"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
 })

 -- configure tailwindcss server
 lspconfig["tailwindcss"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
 })

 -- configure svelte server
 lspconfig["svelte"].setup({
   capabilities = capabilities,
   on_attach = function(client, bufnr)
     on_attach(client, bufnr)

     vim.api.nvim_create_autocmd("BufWritePost", {
       pattern = { "*.js", "*.ts" },
       callback = function(ctx)
         if client.name == "svelte" then
           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
         end
       end,
     })
   end,
 })
 -- configure emmet language server
 lspconfig["emmet_ls"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
 })

--lsp_zero.setup()
require('mason').setup({})
require('mason-lspconfig').setup({
   ensure_installed = {
      "clangd",
      "lua_ls",
      "rust_analyzer",
      "tsserver",
      "html",
      "cssls",
      "tailwindcss",
      "svelte",
      "emmet_ls",
      "pyright"
   },
   automatic_installation = true,
   handlers = {
      lsp_zero.default_setup,
   },
})
--
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior, count = 1 }
cmp.setup({
   completion = {
      completeopt = "menu,menuone,preview,noselect",
   },
   mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
   }),
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
   })
})

lsp_zero.on_attach(function(client, bufnr)
   local opts = { buffer = bufnr, remap = false }

   --vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
   vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
   vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
   vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
   vim.keymap.set("n", "<leader>vrr", "<cmd>Telescope lsp_references<CR>", opts)
   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
   vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
   vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
   vim.keymap.set("n", "<leader>vD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
   vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
   --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
   vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
   vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end)

lsp_zero.setup()

vim.diagnostic.config({
   virtual_text = true
})
