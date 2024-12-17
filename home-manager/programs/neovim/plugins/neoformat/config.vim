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
