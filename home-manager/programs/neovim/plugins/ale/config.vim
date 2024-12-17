let g:ale_fixers = {
  \ 'c': [
  \   'clang-format',
  \   'clangtidy',
  \   'remove_trailing_lines',
  \   'trim_whitespace',
  \  ],
  \ 'c++': [
  \   'clang-format',
  \   'clangtidy',
  \   'remove_trailing_lines',
  \   'trim_whitespace',
  \  ],
  \ 'nix': [
  \   'alejandra',
  \   'remove_trailing_lines',
  \   'statix',
  \   'trim_whitespace',
  \  ],
  \ 'rust': [
  \   'rustfmt',
  \   'remove_trailing_lines',
  \   'trim_whitespace',
  \  ],
  \ 'sql': [
  \   'pgformatter',
  \   'remove_trailing_lines',
  \   'trim_whitespace',
  \  ],
  \ }


let g:ale_cpp_clangtidy_check_options = '
  \ -checks=*,
  \ -llvm-header-guard,
  \ -cppcoreguidelines-pro-bounds-array-to-pointer-decay,
  \ -hicpp-no-array-decay,
  \ -fuchsia-statically-constructed-objects,
  \ -fuchsia-overloaded-operator,
  \ -hicpp-vararg'
let g:ale_cpp_clangformat_executable = 'clang-format'
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_cpp_cc_options = '-std=c++20'
let g:ale_rust_rustfmt_options = '--edition 2021 --config max_width=80,tab_spaces=2'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 0
let mapleader = ";"
nnoremap <leader>ta <cmd>ALEToggle<cr>
