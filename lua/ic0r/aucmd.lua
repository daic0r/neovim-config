vim.api.nvim_create_autocmd({ "TextYankPost" }, {
   pattern = "*",
   callback = function(opts)
      vim.highlight.on_yank({
         higroup = "IncSearch",
         timeout = 200,
         on_visual = true,
         virt_text_pos = "overlay",
         virt_text = "Yanked",
      })
   end
})
