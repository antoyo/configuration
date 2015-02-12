" Vundle configuration.
filetype off

set rtp +=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'h1mesuke/vim-unittest'
Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'Shougo/neocomplete.vim'
Plugin 'travitch/hasksyn'
Plugin 'vhdirk/vim-cmake'

Plugin 'a.vim'
Plugin 'comments.vim'
Plugin 'gnupg.vim'
Plugin 'headerguard.vim'
Plugin 'Licenses'
Plugin 'session.vim--Odding'
Plugin 'Syntastic'

call vundle#end()

" Bépo vim shorcuts.
source ~/.vimrc.bepo

" Basic configuration.
set background=dark
set confirm
set icon
set hidden
set nofoldenable
set number
set scrolloff=3
set shortmess+=I
set showcmd
set spelllang=fr
set title

" Completion configuration.
set suffixes+=,,
set wildignore+=*.dyn_hi,*.dyn_o,*.hi,*.o,*.omc,*.toc,*.pdf,*.aux,*.log,*.toc
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
autocmd FileType haskell set makeprg=cabal\ build
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
map <F5> :up<Enter>:make<Enter>
map <F6> :up<Enter>:!cabal test<Enter>
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
let g:session_autosave = 'yes'

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><CR> neocomplete#close_popup() . "\<CR>"

" CMake
let g:cmake_build_type = 'DEBUG'

" Licenses
let g:licenses_authors_name = 'Boucher, Antoni <bouanto@gmail.com>'

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_haskell_checkers = ["hlint"]
let g:syntastic_scala_checkers = []

" Bug fix.
autocmd VimEnter * redraw!
