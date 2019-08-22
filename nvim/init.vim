
set encoding=utf-8
set clipboard=unnamedplus

syntax on

set runtimepath+=~/.config/nvim/
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'StanAngeloff/php.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sleuth'
Plug 'jceb/vim-orgmode'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'racer-rust/vim-racer'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
let NERDTreeStatusline = "         File Browser"

" ALE Lint setting so it does not spam your screen with errors
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'

let g:deoplete#enable_at_startup = 1

" Special
let wallpaper  = "/home/bram/Pictures/muurplaten/muurplaat4.png"
let background = "#0A1218"
let foreground = "#d4d1d1"
let cursor     = "#d4d1d1"

" Colors
let color0  = "#0A1218"
let color1  = "#625D61"
let color2  = "#BD5A30"
let color3  = "#976664"
let color4  = "#C2966C"
let color5  = "#557397"
let color6  = "#7992A4"
let color7  = "#d4d1d1"
let color8  = "#949292"
let color9  = "#625D61"
let color10 = "#BD5A30"
let color11 = "#976664"
let color12 = "#C2966C"
let color13 = "#557397"
let color14 = "#7992A4"
let color15 = "#d4d1d1"

" indenting
filetype indent on

set tabstop=8
set shiftwidth=4
set smarttab
set expandtab
set autoindent

autocmd FileType vue syntax sync fromstart

let g:airline_powerline_fonts=1

if has('mouse')
    set mouse=a
endif

" Keybindings
let mapleader=' '
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader><leader> :w<CR>
nnoremap <silent> <leader>qw :wq<CR>
nnoremap <silent> <leader>qq :q<CR>
nnoremap <silent> <leader>qf :q!<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fd :call Fzf_dev()<CR>
nnoremap <silent> <leader>bb :Buffers<CR>

let g:python_host_prog = '/usr/bin/python'

" Rust
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Custom FZF with file previews + devicons
" No ctrl+x, ctrl+v, ctrl+t though and a bit slower :(
function! Fzf_dev()
  let l:fzf_files_options =
        \ '--preview "echo {} | tr -s \" \" \"\n\" | tail -1 | xargs rougify | head -'.&lines.'"'
  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:parts = split(a:item, ' ')
    let l:file_path = get(l:parts, 1, '')
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
