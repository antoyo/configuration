" Bépo vim shorcuts.
source ~/.vimrc.bepo

" Basic configuration.
set background=dark
set confirm
set icon
set hidden
set number
set scrolloff=3
set shortmess+=I
set showcmd
set title
set wildmenu
set wildmode=longest,list,full

" Search configuration.
set gdefault
set hlsearch
set ignorecase
set incsearch
set matchpairs+=<:>
set smartcase

" Indentation configuration.
set expandtab
set formatoptions=ro
set shiftwidth=4
set tabstop=4

" Syntax configuration.
syntax on
highlight NbSp ctermbg=lightred
match NbSp /\%xa0/

" File type configuration.
filetype plugin indent on
autocmd FileType c,cpp setlocal cindent
autocmd FileType python setlocal autoindent
autocmd BufRead,BufNewFile *.cls set filetype=tex

" Automatically apply changes from configuration file.
if has("autocmd")
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

" Abbreviation.
iabbrev #d #define
iabbrev #i #include

" Shorcuts.
map <F2> :shell<Enter>
map <F4> :CMake<Enter>
map <F5> :make<Enter>
map <F6> :!%<Enter>
map <C-K> :nohlsearch<Enter>
map ga <C-^>
map gt <C-]>

" Commands.
command! W write

" Plugin configuration.
" HeaderGuard
function! g:HeaderguardName()
    return "DEF_" . toupper(substitute(expand('%:t'), '.hpp', '', ''))
endfunction

function! g:HeaderguardLine3()
    return "#endif"
endfunction

" Kwbd
nmap <C-W> <Plug>Kwbd

" Session.
let g:session_persist_globals = ['&makeprg', 'g:cmake_build_type', 'g:syntastic_tex_checkers']
autocmd VimEnter * delcommand OpenTabSession

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 

" CMake
let g:cmake_build_type = 'DEBUG'

" Licenses
let g:licenses_authors_name = 'Boucher, Antoni <bouanto@gmail.com>'

" LaTeX Suite
let g:tex_flavor = "latex"

" Syntastic.
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1

" Bug fix.
autocmd VimEnter * redraw!
