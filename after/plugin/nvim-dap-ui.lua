require "dapui".setup({
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
