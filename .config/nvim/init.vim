" Plugins.
call plug#begin()

Plug 'antoyo/vim-bepo'
Plug 'antoyo/vim-licenses'
Plug 'antoyo/vim-sessions'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'benekastah/neomake'
Plug 'cespare/vim-toml'
Plug 'dahu/vimple'
Plug 'dahu/Asif'
Plug 'dahu/vim-asciidoc'
Plug 'h1mesuke/vim-unittest'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'antoyo/semantic-highlight.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sjl/gundo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'a.vim'
Plug 'fugitive.vim'
Plug 'gitignore'
Plug 'gnupg.vim'
Plug 'The-NERD-Commenter'

call plug#end()

" Custom functions.
" Close completion popup and press Enter.
function! s:complete_cr_function()
    return deoplete#mappings#close_popup() . "\<CR>"
endfunction

" Basic configuration.
set confirm
set hidden " Avoid unloading a buffer when editing another file.
set sessionoptions=buffers,curdir " Only save the buffers and the current directory in the session.
set spelllang=fr
set tags=./.tags
set matchpairs+=<:> " Enable % to jump from < to >.
set notimeout " Disable the timeout.

let mapleader = "\<Space>"

" UI configuration.
set background=dark
set cursorline " Highlight the active line.
set inccommand=split " Incremental visual feedback for the substitute command.
set list listchars=tab:▸\ ,nbsp:¬,trail:· " Display a character on tabs, nbsp and trailing whitespace.
set mouse= " Disable the mouse.
set nofoldenable " Open all folds.
set noshowmode " Hide the mode since the airline already shows it.
set number
set scrolloff=3 " Set to 3 the number of lines to keep above and below the cursor.
set shortmess+=cI " Hide completion (c) and intro (I) message.
set showcmd
set title

" Completion configuration.
set completeopt -=preview " Disable the preview window for the completions.
set suffixes +=,, " Ignore files without extension (probably binary files) in file name completion.
set wildmenu " Show completions in commands.
set wildmode =longest,list,full
set wildignore+=Cargo.lock " Ignore these files in file completion.

" Search configuration.
set gdefault " Enable global substitute (all matches in a line are substituted).
set hlsearch " Highlight search matches.
set incsearch " Enable incremental search.

" Indentation configuration.
set expandtab " Convert inserted tabs to spaces.
set formatoptions=ro " Insert comment leader when hitting Enter or o/O.
set shiftwidth=4 " Auto-indent this number of space.
set tabstop=4 " Tabs will be shown on 4 characters.

" Syntax configuration.
syntax on
" Color the special keys (tabs, trailing spaces, nbsp) in red.
highlight SpecialKey ctermbg=red
" Disable this special keys highlighting in normal mode.
autocmd InsertEnter * highlight clear SpecialKey
autocmd InsertLeave * highlight SpecialKey ctermbg=red
" Highlight the current line instead of underlining it.
highlight CursorLine cterm=NONE ctermbg=234

" File type configuration.
filetype plugin indent on

" Autocommands.
augroup filegroup
    autocmd FileType c,cpp setlocal cindent
    autocmd FileType python setlocal autoindent
    autocmd FileType asciidoc set nospell
    autocmd BufWritePost * if &ft != "cpp" && &ft != "rust" | Neomake | endif
    autocmd BufWritePost *.rs Neomake! clippy
    autocmd VimLeave * CurrentSessionSave
augroup END

" Disable F1, ex mode and Ctrl-Z shortcuts.
map <F1> <nop>
imap <F1> <nop>
nnoremap Q <nop>
nnoremap <C-Z> <nop>

" Disable Ctrl-C.
cmap <C-c> <nop>
imap <C-c> <nop>
vmap <C-c> <nop>

" Shorcuts.
" Go to alternate buffer.
map ga <C-^>
" Navigate link.
map gt <C-]>
" Select the last inserted text.
nnoremap gV `[v`]
" Copy the whole buffer to the system clipboard.
map <C-S> magg"+yG'azz
map <C-T> :call system("xclip -sel clip", system("include_replace src/main.rs"))<CR>
" Open new lines without going to insert mode.
nmap <S-CR> O<Esc>
nmap <expr> <CR> &modifiable?"o<Esc>":"<CR>"
noremap ; $
" Close popup and add a new line when hitting Enter.
inoremap <silent> <CR> <C-r>=<SID>complete_cr_function()<CR>

" Commands.
" TODO: refactor these commands into a single one.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rgw
  \ call fzf#vim#grep(
  \   'rg --word-regexp --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" TODO: add shorcuts to switch or delete buffers.
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>e :set spelllang=en<CR>:set spell<CR>
nnoremap <Leader>g :Rg 
nnoremap <Leader>h :hide<CR>
nnoremap <Leader>l "*p
nnoremap <Leader>L "*P
nnoremap <Leader>n :only<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>* :Rgw <C-R><C-W><CR>
nnoremap <Leader>q :update<CR>:q<CR>
nnoremap <Leader>s /\<\><Left><Left>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>w :w<CR>

command! GpushNew :Gpush origin -u HEAD

" Plugin configuration.
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])

" Vim Racer
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

" GUndo
let g:gundo_map_move_older = "t"
let g:gundo_map_move_newer = "s"

" Vimple fix.
let vimple_init_vn = 0

" Fix to show the tabs at startup.
redraw
