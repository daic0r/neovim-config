local format_group = vim.api.nvim_create_augroup("lsp_autoformat", { clear = false })

vim.api.nvim_create_autocmd('LspAttach', {
   desc = 'LSP actions',
   callback = function(args)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      vim.keymap.set("n", "<leader>vrr", "<cmd>Telescope lsp_references<CR>", opts)
      vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", opts)
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

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.supports_method("textDocument/formatting") then
         vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
         end, { buffer = bufnr, desc = "[lsp] format" })

         -- format on save
         --[[
         vim.api.nvim_clear_autocmds({ buffer = bufnr, group = format_group })
         vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            group = format_group,
            callback = function()
               vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
            desc = "[lsp] format on save",
         })
         --]]
      end

      if client.supports_method("textDocument/rangeFormatting") then
         vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
         end, { buffer = bufnr, desc = "[lsp] format" })
      end
   end,
})

vim.api.nvim_create_autocmd('LspAttach', {
   desc = 'Switch between header and implementation files',
   pattern = { '*.cpp', '*.h' },
   callback = function()
      vim.keymap.set("n", "<M-o>", ":ClangdSwitchSourceHeader<CR>")
   end
})

local mason_lsp = require("mason-lspconfig")
mason_lsp.setup({
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
      "pyright",
   },
   automatic_installation = true,
})
--
-- Enables recogonizition of built-in Neovim symbols
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

mason_lsp.setup_handlers({
   function(server_name)
      lspconfig[server_name].setup({
         capabilities = lsp_capabilities,
      })
   end
})

lspconfig["lua_ls"].setup {
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
}

--[[
 -- configure html server
 lspconfig["html"].setup({
   capabilities = lsp_capabilities,
 })

 -- configure typescript server with plugin
 lspconfig["tsserver"].setup({
   capabilities = lsp_capabilities,
 })

 -- configure css server
 lspconfig["cssls"].setup({
   capabilities = lsp_capabilities,
 })

 -- configure tailwindcss server
 lspconfig["tailwindcss"].setup({
   capabilities = lsp_capabilities,
 })
 --]]

-- configure svelte server
lspconfig["svelte"].setup({
   capabilities = lsp_capabilities,
   on_attach = function(client, bufnr)
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

local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- configure emmet language server
lspconfig["emmet_ls"].setup({
   capabilities = lsp_capabilities,
   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
   init_options = {
      html = {
         options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
         },
      },
   }
})

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

vim.diagnostic.config({
   virtual_text = true
})
