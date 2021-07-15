" .vimrc
" Author: Adrian Kirk
"

" Configure windows plugin path to .vim
if has("win32") || has("win64")
    set runtimepath^=~/.vim
    set runtimepath+=~/.vim/after
    set packpath=$HOME/.vim
endif


set nocompatible                    " use Vim settings, not Vi settings
set modelines=0                     "
let mapleader=","                   " use , (comma) as the leader key

" ------------------------------------------------------------------------------
" COLORS
" ------------------------------------------------------------------------------
syntax on
filetype on                         " syntax highlight based on file extension
set background=dark

" ------------------------------------------------------------------------------
" THEME: NORD
" ------------------------------------------------------------------------------
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 0
colorscheme nord

if (has("termguicolors"))
"  set termguicolors
endif

" ------------------------------------------------------------------------------
" TABS, SPACES, INDENTATION
" ------------------------------------------------------------------------------
set nowrap                          " no line wrap
set tabstop=4                       " number of visual spaces per TAB
set softtabstop=4                   " numer of spaces in tab when editing
set expandtab                       " tabs are spaces
set shiftwidth=4                    " number of spaces for a single tab
set smarttab                        " tab to the next indent
set autoindent                      " new lines inherit indentation
filetype plugin indent on           " smart auto indentation
match ErrorMsg '\s\+$'              " Highlight trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e  " remove trailing whitespaces automatically


" ------------------------------------------------------------------------------
" CONFIGURATION
" ------------------------------------------------------------------------------
set title                           " window title for current file
set number                          " show line numbers
set showcmd                         " show incomplete command in bottom bar
set wildmenu                        " visual autocomplete for command menu
" set lazyredraw                      " only redraw when needed, not in macros
set showmatch                       " highlight matching [{()}]
set backspace=indent,eol,start      " backspacing over intentation, line breaks
set history=1000                    " set big history of executed commands
set autoread                        " automatically re-read files if unmodified
set tabpagemax=40                   " maximum number of tab pages
"set cursorline                     " highlight the current line
"highlight CursorLine ctermbg=darkgrey
set exrc                            " project specific .vimrc

" NOTE: very slow in ConsoleZ and RDP using relative line numbers
set relativenumber                  " show relative line numbers
augroup toggle_relative_number      " auto toggle absolute/relative for INS/NOR
autocmd InsertEnter * :setlocal norelativenumber | set number
autocmd InsertLeave * :setlocal relativenumber


" ------------------------------------------------------------------------------
" FILES
" ------------------------------------------------------------------------------
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80


" ------------------------------------------------------------------------------
" SWAP AND BACKUP
" ------------------------------------------------------------------------------
set directory=$HOME/.vimfiles/swp//
set nobackup
set nowb
set undofile                        " maintain undo history between files
set undodir=$HOME/.vimfiles/undo


" ------------------------------------------------------------------------------
" SEARCH
" ------------------------------------------------------------------------------
set hlsearch                        " highlight search results
set incsearch                       " incremental search
set ignorecase                      " ignore case when searching

" ESC hides search highlight
" noremap <silent> <ESC> :nohlsearch<BAR>:echo<CR>
" Disabled mapping ESC to hide search highlight. It was causing issues on OSX
" always starting in REPLACE mode.
nnoremap <leader><space> :noh<cr>   " map <leader><space> to hide search hilight

" ------------------------------------------------------------------------------
" RENDERING
" ------------------------------------------------------------------------------
set encoding=utf-8                  " unicode
set scrolloff=3                     " lines to keep above and below the cursor
set sidescrolloff=5                 " columns to keep left and right of the csr


" ------------------------------------------------------------------------------
" MAPPING
" ------------------------------------------------------------------------------
inoremap jj <ESC>                   " map jj to ESC

" move between buffers
map <C-J> <ESC>:bprev<CR>
map <C-K> <ESC>:bnext<CR>


map <leader>s :source ~\.vimrc<CR>                      " \s reloads .vimrc

nnoremap <space> za

" ------------------------------------------------------------------------------
" WORKING WITH SPLIT WINDOWS
" ------------------------------------------------------------------------------
map <C-h> <C-w>h                    " switch window left
map <C-l> <C-w>l                    " switch window right
" map <C-j> <C-w>j                    " switch window down
" map <C-k> <C-w>k                    " switch window up
nnoremap <leader>w <C-w>v<C-w>l     " new vertical split and switch to it

" ------------------------------------------------------------------------------
" ABBREVIATIONS
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" PLUGIN: CSV
" ------------------------------------------------------------------------------

filetype plugin on

" ------------------------------------------------------------------------------
" PLUGIN: LIGHTLINE
" ------------------------------------------------------------------------------

set laststatus=2                    " additional status line for airline
set noshowmode                      " hide --INS-- in status -> airline
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ }
" ------------------------------------------------------------------------------
" PLUGIN: NERDTree
" ------------------------------------------------------------------------------

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Close VIM when NERDTree is the last window

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let NERDTreeShowHidden=1            " Show hidden files
let NERDTreeQuitOnOpen=1            " Close NERDTree after a file is open
