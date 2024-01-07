local M = {
   'nvim-treesitter/nvim-treesitter',
}

M.config = function()
   require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "cpp", "rust", "c", "lua", "vim", "vimdoc", "query", "make" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
         enable = true,

         -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
         --[[
         disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
               return true
            end
         end,
         --]]

         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
         -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
         -- Using this option may slow down your editor, and you may see some duplicate highlights.
         -- Instead of true it can also be a list of languages
         additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
         enable = true,
         keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
         },
      },
      textobjects = {
         select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
               -- You can use the capture groups defined in textobjects.scm
               ['aa'] = '@parameter.outer',
               ['ia'] = '@parameter.inner',
               ['af'] = '@function.outer',
               ['if'] = '@function.inner',
               ['ac'] = '@class.outer',
               ['ic'] = '@class.inner',
               ['a='] = '@assignment.outer',
               ['i='] = '@assignment.inner',
               ['l='] = '@assignment.lhs',
               ['r='] = '@assignment.rhs',
               ['ai'] = '@conditional.outer',
               ['ii'] = '@conditional.inner',
               ['al'] = '@loop.outer',
               ['il'] = '@loop.inner',
            },
         },
         move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
               [']m'] = '@function.outer',
               [']]'] = '@class.outer',
            },
            goto_next_end = {
               [']M'] = '@function.outer',
               [']['] = '@class.outer',
            },
            goto_previous_start = {
               ['[m'] = '@function.outer',
               ['[['] = '@class.outer',
            },
            goto_previous_end = {
               ['[M'] = '@function.outer',
               ['[]'] = '@class.outer',
            },
         },
         swap = {
            enable = true,
            swap_next = {
               ['<leader>sa'] = '@parameter.inner',
            },
            swap_previous = {
               ['<leader>sA'] = '@parameter.inner',
            },
         },
      },
   }

   vim.cmd.TSUpdate()
end

return M
