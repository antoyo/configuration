" vim-plug coniguration.
call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'cespare/vim-toml'
Plug 'h1mesuke/vim-unittest'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-grepper'
Plug 'phildawes/racer'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim'

Plug 'ctrlp.vim'
Plug 'vim-misc'
Plug 'easytags.vim'
Plug 'fugitive.vim'
Plug 'gitignore'
"Plug 'indentLine.vim' " TODO: to remove.
Plug 'The-NERD-Commenter'
Plug 'gnupg.vim'
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

let mapleader = "\<Space>"

" Completion configuration.
set completeopt -=preview
set suffixes +=,,
set wildmenu
set wildmode =longest,list,full
set wildignore+=Cargo.lock,*.class " TODO: remove *.class.

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
" TODO: to remove
autocmd FileType scheme imap \ λ

" Automatically apply changes from configuration file.
autocmd! bufwritepost .nvimrc source ~/.nvimrc

" Abbreviation. TODO: to remove.
iabbrev #d #define
iabbrev #i #include

" Shorcuts.
map <F1> <nop>
imap <F1> <nop>
map ga <C-^>
map gt <C-]>
map <C-S> magg"+yG'azz

" vim-grepper shortcuts.
nmap <Leader>g <plug>(Grepper)
xmap <Leader>g <plug>(Grepper)
nmap gs <plug>(GrepperMotion)
xmap gs <plug>(GrepperMotion)

nnoremap <Leader>q :update<CR>:q<CR>
nnoremap <Leader>m :up<Enter>:make<CR>
nnoremap <Leader>r :nohlsearch<CR>
nnoremap <Leader>s :terminal<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>n :only<CR>
nnoremap <Leader>h :hide<CR>

command! GpushNew :Gpush origin -u HEAD

" Plugin configuration.
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Licenses
let g:licenses_authors_name = 'Boucher, Antoni <bouanto@zoho.com>'

" Session
let g:session_autosave = 'yes'
let g:session_persist_globals = ['&makeprg']

" Neomake
autocmd! BufWritePost * if &ft != 'rust' | Neomake | endif
autocmd! BufWritePost *.rs Neomake! cargo
let g:neomake_open_list = 2

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
let g:ctrlp_working_path_mode = 0

" Easytags
let g:easytags_dynamic_files = 2

" Grepper
let g:grepper = {}
let g:grepper.programs = ['ag']

" Racer
let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH = "/usr/src/rust/src/"
