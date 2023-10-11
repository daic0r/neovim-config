local dapui = require"dapui"
local utils = require"ic0r.utils"

dapui.setup({
   layouts = { {
      elements = { {
         id = "scopes",
         size = 0.33
      }, {
         id = "breakpoints",
         size = 0.33
      }, {
         id = "watches",
         size = 0.33
      } },
      position = "left",
      size = 50
   }, {
      elements = { {
         id = "repl",
         size = 0.5
      }, {
         id = "stacks",
         size = 0.5
      } },
      position = "bottom",
      size = 10
   } },
})

utils.safe_set_keymap("n", "<leader>do", dapui.open)
utils.safe_set_keymap("n", "<leader>dc", dapui.close)

vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text=' ﳁ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text=' ', texthl='DapLogPoint' })
vim.fn.sign_define('DapStopped', { text=' ', texthl='DapStopped' })
