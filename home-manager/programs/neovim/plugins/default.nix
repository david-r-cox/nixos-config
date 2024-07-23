{ vimPlugins }:
with vimPlugins; [
  {
    plugin = aerial-nvim; # TODO: Broken?
    config = builtins.readFile (./aerial-nvim/config.vim);
  }
  {
    plugin = ale;
    config = builtins.readFile (./ale/config.vim);
  }
  {
    plugin = coc-git;
    config = builtins.readFile (./coc-git/config.vim);
  }
  {
    plugin = git-blame-nvim;
    config = builtins.readFile (./git-blame-nvim/config.vim);
  }
  {
    plugin = lazygit-nvim;
    config = builtins.readFile (./lazygit-nvim/config.vim);
  }
  {
    plugin = lualine-nvim;
    type = "lua";
    config = builtins.readFile (./lualine-nvim/config.lua);
  }
  {
    plugin = minimap-vim;
    config = builtins.readFile (./minimap-vim/config.vim);
  }
  {
    plugin = nvim-tree-lua;
    config = builtins.readFile (./nvim-tree-lua/config.vim);
  }
  {
    plugin = nvim-treesitter.withPlugins (p: [
      p.c
      p.cpp
      p.haskell
      p.javascript
      p.nix
      p.python
      p.rust
      p.tsx
      p.yaml
    ]);
    type = "lua";
    config = builtins.readFile (./nvim-treesitter/withAllGrammars/config.lua);
  }
  {
    plugin = telescope-nvim;
    config = builtins.readFile (./telescope-nvim/config.vim);
  }
  {
    plugin = markdown-preview-nvim;
    config = ''
      " set to 1, nvim will open the preview window after entering the markdown buffer
      let g:mkdp_auto_start = 0

      " set to 1, the nvim will auto close current preview window when change
      " from markdown buffer to another buffer
      let g:mkdp_auto_close = 1
      let g:mkdp_theme = 'light'
      let g:mkdp_preview_options = {
        \ 'mkit': {},
        \ 'katex': {},
        \ 'uml': {},
        \ 'maid': {},
        \ 'disable_sync_scroll': 1,
        \ 'sync_scroll_type': 'middle',
        \ 'hide_yaml_meta': 1,
        \ 'sequence_diagrams': {},
        \ 'flowchart_diagrams': {},
        \ 'content_editable': v:false,
        \ 'disable_filename': 0,
        \ 'toc': {}
        \ }
    '';
  }
  {
    plugin = neoformat;
    config = ''
      " custom setting for clangformat
      let g:neoformat_cpp_clangformat = {
          \ 'exe': 'clang-format',
          \ 'args': ['--style="{IndentWidth: 2}"']
      \}
      let g:neoformat_enabled_cpp = ['clangformat']
      let g:neoformat_enabled_c = ['clangformat']
      let g:neoformat_rust_rustfmt = {
          \ 'exe': 'rustfmt',
          \ 'args': [ '--edition 2021'],
          \ 'replace': 1,
      \}
      let g:neoformat_enabled_rust = ['neoformat_rust_rustfmt']
      augroup fmt
        autocmd!
        autocmd BufWritePre *.tsx undojoin | Prettier
        "autocmd BufWritePre *.[ch][pp]? undojoin | Neoformat
        " autocmd BufWritePre *.rs undojoin | Neoformat
        " TODO: The following breaks .tsx files:
        " au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
      augroup END
    '';
  }
  {
    plugin = smart-splits-nvim;
    type = "lua";
    config = ''
      vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
      vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
      vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
      vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
    '';
  }
  {
    plugin = trim-nvim;
    type = "lua";
    config = ''
      require('trim').setup({
        ft_blocklist = {"markdown"},
        --patterns = {
        --  [[%s/\(\n\n\)\n\+/\1/]],
        --},
        trim_on_write = true,
      })
    '';
  }
  {
    plugin = litee-nvim;
  }
  {
    plugin = litee-calltree-nvim;
    type = "lua";
    config = ''
      require('litee.lib').setup({})
      require('litee.calltree').setup({})
    '';
  }
  {
    plugin = ollama-nvim;
    type = "lua";
    config = ''
      require('ollama').setup({
        model = "llama3",
        url = "http://127.0.0.1:11434",
        serve = {
          on_start = false,
          command = "ollama",
          args = { "serve" },
          stop_command = "pkill",
          stop_args = { "-SIGTERM", "ollama" },
        },
        prompts = {
          Sample_Prompt = {
            prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
            input_label = "> ",
            model = "llama3",
            action = "display",
          }
        }
      })
      vim.keymap.set('x', '<leader>i', ':Ollama<cr>')
    '';
  }
  {
    plugin = codecompanion-nvim;
    type = "lua";
    config = ''
            require("codecompanion").setup({
              adapters = {
                ollama = function()
                  return require("codecompanion.adapters").use("ollama", {
                    schema = {
                      model = {
                        default = "llama3",
                      },
                    },
                  })
                end,
              },
              strategies = {
                chat = {
                  adapter = "ollama"
                },
                inline = {
                  adapter = "ollama"
                },
                agent = {
                  adapter = "anthropic"
                }
              }
            })

      vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    '';
  }
  {
    plugin = coc-nvim;
    type = "lua";
    config = builtins.readFile (./coc-nvim/config.lua);
  }
  {
    plugin = indent-blankline-nvim-lua;
    type = "lua";
    config = ''
      require("ibl").setup()
    '';
  }
  {
    plugin = trouble-nvim;
    type = "lua";
    config = ''
      require("trouble").setup()
    '';
  }
  {
] ++ [
  #coc-clangd
  #coq_nvim
  coc-rust-analyzer
  coc-tailwindcss
  coc-tsserver
  coc-vimlsp
  diffview-nvim
  lsp_signature-nvim
  nvim-lspconfig
  nvim-spectre
  plenary-nvim
  twilight-nvim
  vim-clang-format
  vim-dadbod
  vim-dadbod-completion
  vim-dadbod-ui
  vim-llvm
  vim-prettier
  vim-prisma
  vim-startify
  vim-svelte
] ++ [
  # Colorschemes:
  {
    plugin = aurora;
    config = builtins.readFile (./aurora/config.vim);
  }
  catppuccin-nvim
  edge
  embark-vim
  gruvbox-flat-nvim
  kanagawa-nvim
  neovim-ayu
  nightfox-nvim
  oceanic-next
  sonokai
  tokyonight-nvim
  zephyr-nvim
]
