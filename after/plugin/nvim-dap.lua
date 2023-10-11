local dap = require('dap')
local utils = require('ic0r.utils')

utils.safe_set_keymap("n", "<F9>", dap.toggle_breakpoint)
utils.safe_set_keymap("n", "<leader>dcb", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
utils.safe_set_keymap("n", "<F10>", dap.step_over)
utils.safe_set_keymap("n", "<F11>", dap.step_into)
utils.safe_set_keymap("n", "<S-F11>", dap.step_out)
utils.safe_set_keymap("n", "<F5>", function()
   if #dap.status() == 0 then
      local ret = os.execute("cargo build > /dev/null")
      if ret ~= 0 then
         print("Build failed")
         return
      end
      local dap_helper = require("dap-helper")
      dap_helper.setup()
      print(dap_helper.get_launch_args())
      dap_helper.set_launch_args()
   end
   dap.continue()
end)
utils.safe_set_keymap("n", "<F12>", function() dap.disconnect( { restart = false, terminateDebuggee = true } ) end)
utils.safe_set_keymap("n", "<leader>drs", function() dap.disconnect( { restart = true, terminateDebuggee = true } ) end)
utils.safe_set_keymap("n", "<leader>ddab", function() require"dap.breakpoints".clear() end)

dap.configurations.rust = {
  {
    type = "rust",
    name = "Debug",
    request = "launch",
    program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    env = {},
    runInTerminal = false,
  },
}

dap.adapters.rust = {
  type = 'executable',
  command = 'lldb-vscode-15',
  name = 'lldb',
}
local dapui = require("dapui")
utils.safe_set_keymap("n", "<leader>do", dapui.open)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text=' ﳁ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text=' ', texthl='DapLogPoint' })
vim.fn.sign_define('DapStopped', { text=' ', texthl='DapStopped' })
