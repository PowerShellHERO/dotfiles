
" Encode {{{
set nobomb
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
scriptencoding=UTF-8
" }}}
"File, Buffer, Style {{{
" style
set belloff=all
syntax enable
syntax on
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set softtabstop=4
" buffer
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,] " non-stop cursor
set clipboard=unnamed
set number
set nobomb
set hidden       "Even buffer has changed, can buffer other files.
set nobackup     "no backupfile, but make swapfile.
set noundofile
set history=1000
set suffixesadd=.txt,.md
set wildmenu
set wildmode=full
" }}}
"Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
" }}}
" def map {{{
" edit vimrc
" let mapleader = "\<Space>"
noremap <Space>o :edit $MYVIMRC<CR>
autocmd FileType vim noremap <buffer> <Space>e :source %<CR>
" write, quit
nnoremap <Space>w :<c-u>w<CR>
nnoremap <Space>q :<c-u>bdel<CR>
noremap <Space>o :edit $MYVIMRC<CR>
nnoremap <Space>w :<c-u>w<CR>
nnoremap <Space>q :<c-u>bdel<CR>
nnoremap <Space>e :source $MYVIMRC<CR>
" undo redo を <C-u>, <C-r> に
nnoremap <C-u> u

" buffer
nnore <C-j> :enew<CR>
nnore gt :bnext<CR>
nnore - :bnext<CR>
nnore = :bprevious<CR>

set iskeyword+=-,'

nnoremap n gj
nnoremap k gk
map L $
map H ^
noremap! <C-d> <C-h>
inoremap <C-k> <C-o>gk
inoremap <C-n> <C-o>gj
noremap! <C-l> <RIGHT>
noremap! <C-h> <LEFT>
noremap! <C-e> <End>
inoremap <C-u> <ESC>^i
cnoremap <C-k> <UP>
cnoremap <C-n> <DOWN>
cnoremap <C-j> <C-n>
cnoremap <C-u> <HOME>
inoremap <C-b> <C-o>b
inoremap <C-f> <C-o>w
vnoremap n j
vnoremap j n

inoremap <C-j> <C-n>
nnoremap <C-w>n <C-w>j
noremap! <C-o> <Esc>
vnoremap <C-o> <ESC>
inoremap <C-c> <C-o>
nnoremap <C-c> <C-o>
nnoremap o o<Esc>o
noremap <C-h> I

nnore gt :bnext<CR>
nnore - :bnext<CR>
nnore = :bprevious<CR>
nnoremap <C-o> G

nnoremap ; :
nnoremap q; q:
nnoremap <C-l> A
vnoremap <C-l> $A
vnoremap <C-h> I
inoremap <C-v> <ESC>v

" fold
nnoremap zm za
nnoremap zn zj

inoremap <C-z> <C-o>u

nnoremap u {zz
nnoremap e }zz
" search + zz
nnoremap <C-n> nzz
nnoremap <C-k> Nzz
nnoremap * *zz
nnoremap # #zz

" undo
nnoremap <C-u> u
" reset file state
nnoremap <C-z> :e!<CR>
" delver char
nnoremap <C-e> xhep

" select <>
nnoremap vat va<
omap t <

" }}}

