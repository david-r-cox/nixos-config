filetype plugin on
filetype on

set title
set nu
set cursorline
set scrolloff=10
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set termguicolors
set packpath-=/usr/share/nvim/runtime/colors " disable default colors

let g:cocdisable_startup_warning = 1
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

set guifont=FiraMono\ Nerd\ Font\ Mono:h9
let g:neovide_refresh_rate=60
"let g:neovide_no_idle=v:false
"let g:neovide_fullscreen=v:false
let g:neovide_cursor_animation_length=0.025
let g:neovide_cursor_trail_length=0.1
let g:neovide_cursor_antialiasing=v:true
""let g:neovide_cursor_vfx_mode = "ripple"
"let g:neovide_cursor_vfx_opacity=200.0
"let g:neovide_cursor_vfx_particle_lifetime=1.2
"let g:neovide_cursor_vfx_particle_density=7.0
"let g:neovide_cursor_vfx_particle_speed=10.0
"let g:neovide_cursor_vfx_particle_phase=1.5
"let g:neovide_cursor_vfx_particle_curl=1.0
"" let g:rustfmt_autosave = 1

set noshowmatch

nnoremap <leader>, <cmd>windo wincmd =<cr>
nnoremap <leader>to <cmd>CocOutline<cr>

"colorscheme tokyonight-moon
colorscheme sonokai

" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>
