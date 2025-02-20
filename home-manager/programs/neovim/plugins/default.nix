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
    plugin = dressing-nvim;
    type = "lua";
    config = ''
      require("dressing").setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = "Input",

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Can be 'left', 'right', or 'center'
          title_pos = "left",

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "cursor",

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,

          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Options for telescope selector
          -- These are passed into the telescope picker directly. Can be used like:
          -- telescope = require('telescope.themes').get_ivy({...})
          telescope = nil,

          -- Options for fzf selector
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },

          -- Options for fzf-lua
          fzf_lua = {
            -- winopts = {
            --   height = 0.5,
            --   width = 0.5,
            -- },
          },

          -- Options for nui Menu
          nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
              style = "rounded",
            },
            buf_options = {
              swapfile = false,
              filetype = "DressingSelect",
            },
            win_options = {
              winblend = 0,
            },
            max_width = 80,
            max_height = 40,
            min_width = 40,
            min_height = 10,
          },

          -- Options for built-in selector
          builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            buf_options = {},
            win_options = {
              cursorline = true,
              cursorlineopt = "both",
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },

            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      })
    '';
  }
  {
    plugin = codecompanion-nvim;
    type = "lua";
    config = ''
            require("codecompanion").setup({
              adapters = {
                ollama = function()
                  return require("codecompanion.adapters").extend("ollama", {
                    schema = {
                      model = {
                        default = "mistral-small:22b-instruct-2409-q2_K",
                      },
                      num_ctx = {
                        default = 8196,
                      },
                      num_predict = {
                        default = -1,
                      },
                    },
                  })
                end,
                anthropic = function()
                  return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                      api_key = "cmd:cat ~/.anthropic",
                    }})
                end,
              },
              strategies = {
                chat = {
                  adapter = "anthropic"
                },
                inline = {
                  adapter = "ollama"
                },
                agent = {
                  adapter = "ollama"
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
    plugin = nvim-dap;
    type = "lua";
    config = builtins.readFile (./nvim-dap/config.lua);
  }
  {
    plugin = nvim-dap-ui;
    type = "lua";
    config = ''
      require("dapui").setup()
    '';
  }
  {
    plugin = nvim-dap-virtual-text;
    type = "lua";
    config = ''
      require("nvim-dap-virtual-text").setup {
          enabled = true,                        -- enable this plugin (the default)
          enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true,               -- show stop reason when stopped for exceptions
          commented = false,                     -- prefix virtual text with comment string
          only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
          all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
          --- A callback that determines how a variable is displayed or whether it should be omitted
          --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
          --- @param buf number
          --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
          --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
          --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
          --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
          display_callback = function(variable, buf, stackframe, node, options)
          -- by default, strip out new line characters
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value:gsub("%s+", " ")
            else
              return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
            end
          end,
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

          -- experimental features:
          all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                                 -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    '';
  }
] ++ [
  nvim-cmp # TODO: configure
  coc-clangd
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
  nvim-treesitter-parsers.tlaplus
  vim-prettier
  vim-prisma
  vim-startify
  vim-svelte
  nvim-dap-rr
  nvim-dap-ui
] ++ [
  # Colorschemes:
  {
    plugin = aurora;
    config = builtins.readFile (./aurora/config.vim);
  }
  bamboo-nvim
  boo-colorscheme-nvim
  catppuccin-nvim
  citruszest-nvim
  cyberdream-nvim
  deepwhite-nvim
  doom-one-nvim
  edge
  embark-vim
  gruvbox-flat-nvim
  kanagawa-nvim
  melange-nvim
  miasma-nvim
  modus-themes-nvim
  neovim-ayu
  nightfly
  nightfox-nvim
  oceanic-next
  rose-pine
  sonokai
  substrata-nvim
  tokyonight-nvim
  vim-code-dark
  zephyr-nvim
]
