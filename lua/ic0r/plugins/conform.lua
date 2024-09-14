return {
   "stevearc/conform.nvim",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      local conform = require("conform")

      conform.setup({
         formatters_by_ft = {
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            vue = { "prettierd" },
            svelte = { "prettierd" },
            css = { "prettierd" },
            html = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            markdown = { "prettierd" },
            graphql = { "prettierd" },
            lua = { "stylua" },
            python = { "isort", "black" },
         },
      })
   end,
}
