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
    config = builtins.readFile (./markdown-preview-nvim/config.vim);
  }
  {
    plugin = neoformat;
    config = builtins.readFile (./neoformat/config.vim);
  }
  {
    plugin = smart-splits-nvim;
    type = "lua";
    config = builtins.readFile (./smart-splits-nvim/config.lua);
  }
  {
    plugin = trim-nvim;
    type = "lua";
    config = builtins.readFile (./trim-nvim/config.lua);
  }
  {
    plugin = litee-nvim;
  }
  {
    plugin = litee-calltree-nvim;
    type = "lua";
    config = builtins.readFile (./litee-calltree-nvim/config.lua);
  }
  {
    plugin = ollama-nvim;
    type = "lua";
    config = builtins.readFile (./ollama-nvim/config.lua);
  }
  {
    plugin = coc-nvim;
    type = "lua";
    config = builtins.readFile (./coc-nvim/config.lua);
  }
  {
    plugin = indent-blankline-nvim-lua;
    type = "lua";
    config = builtins.readFile (./indent-blankline-nvim/config.lua);
  }
  {
    plugin = trouble-nvim;
    type = "lua";
    config = builtins.readFile (./trouble-nvim/config.lua);
  }
  {
    plugin = dressing-nvim;
    type = "lua";
    config = builtins.readFile (./dressing-nvim/config.lua);
  }
  {
    plugin = codecompanion-nvim;
    type = "lua";
    config = builtins.readFile (./codecompanion-nvim/config.lua);
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
] ++ [
  # Colorschemes:
  {
    plugin = aurora;
    config = builtins.readFile (./aurora/config.vim);
  }
  bamboo-nvim
  catppuccin-nvim
  cyberdream-nvim
  edge
  embark-vim
  gruvbox-flat-nvim
  jellybeans-nvim
  kanagawa-nvim
  melange-nvim
  miasma-nvim
  neovim-ayu
  nightfox-nvim
  oceanic-next
  sonokai
  tokyonight-nvim
  zephyr-nvim
]