require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      c,
      cpp,
      haskell,
      nix,
      python,
      rust,
    },
  },
}
