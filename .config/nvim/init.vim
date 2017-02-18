let g:nvim_path = split(&runtimepath, ",")[0]

" vim-plug coniguration.
call plug#begin(g:nvim_path . "/plugged")

Plug 'antoyo/vim-licenses'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'benekastah/neomake'
Plug 'cespare/vim-toml'
Plug 'dahu/vimple'
Plug 'dahu/Asif'
Plug 'dahu/vim-asciidoc'
Plug 'h1mesuke/vim-unittest'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'a.vim'
Plug 'fugitive.vim'
Plug 'gitignore'
Plug 'gnupg.vim'
Plug 'The-NERD-Commenter'

call plug#end()

function! s:include(file)
    execute "source " . g:nvim_path . "/" . a:file
endfunction

" Bépo vim shorcuts.
call s:include("bepo.vim")

"call s:include("ctags.vim")
call s:include("sessions.vim")

" Basic configuration.
set background=dark
set backupdir =.
set confirm
set icon
set hidden
set inccommand=split
set mouse=
set nofoldenable
set noshowmode
set number
set scrolloff=3
set sessionoptions=buffers,curdir
set shortmess+=cI
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
set wildignore+=Cargo.lock

" Search configuration.
set gdefault
set hlsearch
"set ignorecase
set incsearch
set matchpairs+=<:>
"set smartcase

" Indentation configuration.
set expandtab
set formatoptions=ro
set shiftwidth=4
set tabstop=4

" Syntax configuration.
syntax on
highlight NbSp ctermbg=lightred
match NbSp /\%xa0/
autocmd BufWinEnter * match NbSp /\%xa0/

highlight ExtraWhitespace ctermbg=red
2match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$/
autocmd InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * 2match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" File type configuration.
filetype plugin indent on

" Autocommands.
if !exists("s:autocommands_loaded")
    let s:autocommands_loaded = 1
    autocmd FileType c,cpp setlocal cindent
    autocmd FileType python setlocal autoindent
    autocmd FileType asciidoc set nospell
    "autocmd BufWritePost * call g:ctags#UpdateTags()
    autocmd BufWritePost * if &ft != "cpp" && &ft != "rust" | Neomake | endif
    autocmd BufWritePost *.rs Neomake! clippy
    autocmd VimLeave * CurrentSessionSave
endif

" Disable F1, ex mode and Ctrl-Z shortcuts.
map <F1> <nop>
imap <F1> <nop>
imap <C-c> <Esc>:set relativenumber<CR>
nnoremap Q <nop>
nnoremap <C-Z> <nop>

" Move by screen line instead of file line.
nnoremap <expr> t v:count == 0 ? 'gj' : 'j'
nnoremap <expr> s v:count == 0 ? 'gk' : 'k'

" Shorcuts.
map ga <C-^>
map gt <C-]>
map <C-S> magg"+yG'azz
map <C-T> :call system("xclip -sel clip", system("include_replace src/main.rs"))<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" TODO: add shorcuts to switch or delete buffers.
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>e :set spelllang=en<CR>:set spell<CR>
nnoremap <Leader>g :Rg 
nnoremap <Leader>h :hide<CR>
nnoremap <Leader>n :only<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p :Rg <C-R><C-W><CR>
nnoremap <Leader>q :update<CR>:q<CR>
nnoremap <Leader>s /\<\><Left><Left>
nnoremap <Leader>w :w<CR>
inoremap <silent> <CR> <C-r>=<SID>complete_cr_function()<CR>

function! s:complete_cr_function()
    return deoplete#mappings#close_popup() . "\<CR>"
endfunction

command! GpushNew :Gpush origin -u HEAD

" Plugin configuration.
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])

" Vim Racer.
let g:racer_cmd = '/usr/bin/racer'
let g:racer_no_default_keymappings = 1
let $RUST_SRC_PATH = '/usr/src/rust/src/'

" Licenses
let g:licenses_copyright_holders_name = "Boucher, Antoni <bouanto@zoho.com>"

" Neomake
let g:neomake_open_list = 2

" Airline
set laststatus=2
let g:airline_theme="powerlineish"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" LanguageClient

let g:LanguageClient_serverCommands = {
    \ 'rust': ['cargo', 'run', '--release', '--manifest-path=/home/bouanto/Telechargements/Source/rls/Cargo.toml'],
    \ }

" Vimple fix.
let vimple_init_vn = 0
