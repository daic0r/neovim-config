local M = {
   'simrat39/rust-tools.nvim',
}

M.config = function()
   local rt = require("rust-tools")

   local mason_registry = require("mason-registry")
   local codelldb = mason_registry.get_package("codelldb")
   local extension_path = codelldb:get_install_path() .. "/extension/"
   local codelldb_path = extension_path .. "adapter/codelldb"
   local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

   rt.setup({
      server = {
         on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<leader>ha", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>ag", rt.code_action_group.code_action_group, { buffer = bufnr })
         end,
      },
      dap = {
         adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
         --[[
         adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
         },
         --]]

      },
   })
end

return M
