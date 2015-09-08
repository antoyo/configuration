" vim-plug coniguration.
call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'cespare/vim-toml'
Plug 'h1mesuke/vim-unittest'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-grepper'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'vhdirk/vim-cmake'

Plug 'ctrlp.vim'
Plug 'vim-misc'
Plug 'easytags.vim'
Plug 'fugitive.vim'
Plug 'gitignore'
Plug 'The-NERD-Commenter'
Plug 'The-NERD-tree'
Plug 'gnupg.vim'
Plug 'headerguard'
Plug 'Licenses'
Plug 'session.vim--Odding'

call plug#end()

" Bépo vim shorcuts.
source ~/.nvimrc.bepo

" Basic configuration.
set background=dark
set confirm
set icon
set hidden
set mouse=
set nofoldenable
set noshowmode
set number
set scrolloff=3
set shortmess+=I
set showcmd
set spelllang=fr
set tags=./.tags
set timeoutlen=250
set title

let $PATH = "/usr/bin:" . $PATH
let mapleader = "\<Space>"

" Completion configuration.
set completeopt -=preview
set suffixes +=,,
set wildmenu
set wildmode =longest,list,full
set wildignore+=Cargo.lock

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
autocmd! bufwritepost .nvimrc source ~/.nvimrc

" Abbreviation.
iabbrev #d #define
iabbrev #i #include

" Shorcuts.
map <F1> <nop>
imap <F1> <nop>
map <F4> :CMake<Enter>
map ga <C-^>
map gt <C-]>
vmap <C-Y> :!xclip -f -sel clip<Enter>u
map <C-P> :-1r !xclip -o -sel clip<Enter>
map <C-S> maggVG:!xclip -f -sel clip<Enter>u'a

" vim-grepper shortcuts.
nmap <Leader>g <plug>(Grepper)
xmap <Leader>g <plug>(Grepper)
cmap <Leader>g <plug>(GrepperNext)
nmap gs <plug>(GrepperMotion)
xmap gs <plug>(GrepperMotion)

nnoremap <Leader>q :wq<CR>
nnoremap <Leader>m :up<Enter>:make<CR>
nnoremap <Leader>r :nohlsearch<CR>
nnoremap <Leader>s :terminal<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

command! GpushNew :Gpush origin -u HEAD

" Plugin configuration.
" HeaderGuard
function! g:HeaderguardLine3()
    return "#endif"
endfunction

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" CMake
let g:cmake_build_type = 'DEBUG'

" Licenses
let g:licenses_authors_name = 'Boucher, Antoni <bouanto@zoho.com>'

" Session
let g:session_autosave = 'yes'
let g:session_persist_globals = ['&makeprg', 'g:cmake_build_type', '$PATH']

" Neomake
autocmd! BufWritePost * if &ft != 'rust' | Neomake | endif
autocmd! BufWritePost *.rs Neomake! cargo
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['jshint']

" Airline
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" CtrlP
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")':   ['<c-t>', '<down>'],
      \ 'PrtSelectMove("k")':   ['<c-s>', '<up>'],
      \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>'],
      \ 'AcceptSelection("t")': [],
      \ }

" Easytags
let g:easytags_dynamic_files = 2

" Grepper
let g:grepper = {}
let g:grepper.programs = ['ag']
