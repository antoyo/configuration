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

" Completion configuration.
set suffixes+=,,
set wildignore+=*.hi,*.o,*.omc
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
map <F1> <nop>
imap <F1> <nop>
map <F2> :shell<Enter>
map <F4> :CMake<Enter>
map <F5> :make<Enter>
map <F6> :!omake clean \| cat<Enter>
map <C-K> :nohlsearch<Enter>
map ga <C-^>
map gt <C-]>
vmap <C-Y> :!xclip -f -sel clip<Enter>
map <C-P> :-1r !xclip -o -sel clip<Enter>

" Commands.
command! W write

" Plugin configuration.
" HeaderGuard
function! g:HeaderguardLine3()
    return "#endif"
endfunction

" Session.
let g:session_persist_globals = ['&makeprg', 'g:cmake_build_type']
autocmd VimEnter * delcommand OpenTabSession
let g:session_autosave = 'yes'

" NeoComplCache
let g:neocomplete#enable_at_startup = 1
inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>" 

" CMake
let g:cmake_build_type = 'DEBUG'

" Licenses
let g:licenses_authors_name = 'Boucher, Antoni <bouanto@gmail.com>'

" Bug fix.
autocmd VimEnter * redraw!
