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

"let g:ale_disable_lsp = 'auto'
"let g:ale_completion_enabled = 1
"let g:ale_completion_autoimport = 1
let g:ale_disable_lsp = 1

set guifont=VictorMono\ Nerd\ Font:h9
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

colorscheme kanagawa-lotus

" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>

command! -nargs=0 ReloadConfig source ~/.config/nvim/init.lua
nnoremap <leader>rr :ReloadConfig<CR>

function! YankNearestCodeBlock(include_delimiters)
  " Save the current cursor position
  let l:save_pos = getpos(".")
  let l:current_line = line(".")

  " Initialize variables for tracking the nearest block
  let l:nearest_start = 0
  let l:nearest_end = 0
  let l:min_distance = 999999

  " Search for all code blocks in the buffer
  let l:block_pairs = []
  call cursor(1, 1)
  while search('^```\(\w*\)', 'W') > 0
    let l:start = line(".")
    let l:lang = matchstr(getline('.'), '^```\zs\w*\ze')
    if search('^```$', 'W') > 0
      let l:end = line(".")
      call add(l:block_pairs, [l:start, l:end, l:lang])
    endif
  endwhile

  " Find the nearest code block
  for [l:start, l:end, l:lang] in l:block_pairs
    let l:distance = min([abs(l:current_line - l:start), abs(l:current_line - l:end)])
    if l:distance < l:min_distance
      let l:min_distance = l:distance
      let l:nearest_start = l:start
      let l:nearest_end = l:end
      let l:nearest_lang = l:lang
    endif
  endfor

  " If no code block found, return
  if l:nearest_start == 0
    call setpos('.', l:save_pos)
    echohl ErrorMsg
    echom "No code block found!"
    echohl None
    return
  endif

  " Yank the content of the nearest code block
  let l:yank_start = a:include_delimiters ? l:nearest_start : l:nearest_start + 1
  let l:yank_end = a:include_delimiters ? l:nearest_end : l:nearest_end - 1

  call cursor(l:yank_start, 1)
  normal! v
  call cursor(l:yank_end, 1)
  normal! $y

  " Copy to system clipboard
  let @+ = @"

  " Restore the cursor position
  call setpos('.', l:save_pos)

  " Highlight the yanked code block
  call matchadd('Search', '\%>' . (l:nearest_start - 1) . 'l\%<' . (l:nearest_end + 1) . 'l.*')
  redraw

  " Use :echohl to set highlight group, then clear it
  echohl WarningMsg
  echom printf("Code block%s (lines %d-%d) copied to system clipboard!",
        \ (empty(l:nearest_lang) ? "" : " (" . l:nearest_lang . ")"),
        \ l:yank_start,
        \ l:yank_end)
  echohl None

  " Remove the highlight after a short delay
  call timer_start(1000, {-> execute('call clearmatches()')})
endfunction

" Map the function to key combinations
nnoremap <silent> <leader>j :call YankNearestCodeBlock(0)<CR>
nnoremap <silent> <leader>J :call YankNearestCodeBlock(1)<CR>


function! YankSelectionAsCodeBlock() range
  " Get the visually selected text
  let l:selection = getline(a:firstline, a:lastline)

  " Get the file extension (language)
  let l:file_extension = expand('%:e')

  " Create the code block
  let l:code_block = ['```' . l:file_extension]
  call extend(l:code_block, l:selection)
  call add(l:code_block, '```')

  " Join the lines and copy to Vim's default clipboard
  let @" = join(l:code_block, "\n")

  " Display a success message
  echohl WarningMsg
  echom printf("Selection copied as %s code block (lines %d-%d)", l:file_extension, a:firstline, a:lastline)
  echohl None
endfunction

" Map the function to a key combination for visual mode
vnoremap <silent> <leader>c :call YankSelectionAsCodeBlock()<CR>

" Prettier shortcut
nnoremap <silent> <leader>p :Prettier<CR>
