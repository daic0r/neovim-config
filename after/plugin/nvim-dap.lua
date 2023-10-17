local dap = require('dap')
local dap_helper = require("dap-helper")

vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dcb", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<S-F11>", dap.step_out)
vim.keymap.set("n", "<F5>", function()
   if #dap.status() == 0 then
      local ret = os.execute("cargo build > /dev/null")
      if ret ~= 0 then
         vim.notify("Build failed", vim.log.levels.ERROR)
         return
      end
      dap_helper.set_launch_args(dap_helper.get_launch_args())
      local file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf()})
      dap_helper.set_startup_program(dap_helper.get_startup_program(filetype))
   end
   dap.continue()
end)
vim.keymap.set("n", "<F12>", function() dap.disconnect( { restart = false, terminateDebuggee = true } ) end)
vim.keymap.set("n", "<leader>drs", function() dap.disconnect( { restart = true, terminateDebuggee = true } ) end)
vim.keymap.set("n", "<leader>ddab", function() require"dap.breakpoints".clear() end)

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
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
