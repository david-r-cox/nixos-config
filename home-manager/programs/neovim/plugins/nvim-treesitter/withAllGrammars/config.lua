require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      agda,
      c,
      cpp,
      elixir,
      haskell,
      html,
      javascript,
      nix,
      python,
      rust,
      tlaplus,
      tsx,
    },
  },
}
