vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	desc = "prevent colorscheme clears self-defined DAP icon colors.",
	callback = function()
		vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
		vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
		vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
	end
})

function SetColors(color)
   --color = color or "tokyonight-night"
   --vim.cmd.colorscheme(color)

   --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
   --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColors()
