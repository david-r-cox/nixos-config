let mapleader = ";"
nnoremap <leader>fa <cmd>Telescope telescope-tabs list_tabs<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fz <cmd>Telescope colorscheme<cr>
lua << EOF
  require "telescope".setup {
    pickers = {
      colorscheme = {
        enable_preview = true, -- broken
        ignore = {
          "blue",
          "default",
          "delek",
          "desert",
          "elflord",
          "evening",
          "industry",
          "koehler",
          "morning",
          "murphy",
          "pablo",
          "peachpuff",
          "ron",
          "shine",
          "slate",
          "torte",
        },
      }
    }
  }
EOF
