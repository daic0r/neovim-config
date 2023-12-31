return {
   'barrett-ruth/live-server.nvim',
   build = 'yarn global add live-server',
   config = function()
      require('live-server').setup {
         -- Arguments passed to live-server via `vim.fn.jobstart()`
         --                -- Run `live-server --help` to see list of available options
         --                               -- For example, to use port 7000 and browser firefox:
         --                                              -- args = { '--port=7000', '--browser=firefox' }
         args = { '--port=5000' }
      }
      end
}
