let mapleader = ";"
nnoremap <leader>fa <cmd>Telescope telescope-tabs list_tabs<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope hoogle<cr>
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
    },
    extensions = {
      hoogle = {
        render = 'treesitter',       -- Select the preview render engine: default|treesitter
                                  -- default = simple approach to render the document
                                  -- treesitter = render the document by utilizing treesitter's html parser
        renders = {               -- Render specific options
          treesitter = {
            remove_wrap = false   -- Remove hoogle's own text wrapping. E.g. if you uses neovim's buffer wrapping
                                  -- (autocmd User TelescopePreviewerLoaded setlocal wrap)
          }
        }
      }
    },
  }
  require'telescope'.load_extension'hoogle'
EOF
