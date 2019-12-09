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
let mapleader = ","                 " use , (comma) as the leader key

" ------------------------------------------------------------------------------
" COLORS
" ------------------------------------------------------------------------------
syntax on
filetype on                         " syntax highlight based on file extension
set background=dark


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
set lazyredraw                      " only redraw when needed, not in macros
set showmatch                       " highlight matching [{()}]
set noshowmode                      " hide --INS-- in status -> airline
set backspace=indent,eol,start      " backspacing over intentation, line breaks
set history=1000                    " set big history of executed commands
set autoread                        " automatically re-read files if unmodified
set laststatus=2                    " additional status line for airline
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
set colorcolumn=85


" ------------------------------------------------------------------------------
" SWAP AND BACKUP
" ------------------------------------------------------------------------------
set directory=$HOME/.vimfiles/swp//
set nobackup
set nowb


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
map <C-j> <C-w>j                    " switch window down
map <C-k> <C-w>k                    " switch window up
nnoremap <leader>w <C-w>v<C-w>l     " new vertical split and switch to it

" ------------------------------------------------------------------------------
" NETRW
" ------------------------------------------------------------------------------
let g:netrw_liststyle = 1           " Explorer list style = Detailed
let g:netrw_banner = 1              " Hide banner
let g:netrw_browse_split = 4        " Load file in split and keep netrw
let g:netrw_winsize = 33            " 33%

fun! VexToggle(dir)
    if exists("t:vex_buf_nr")
        call VexClose()
    else
        call VexOpen(a:dir)
    endif
endf

fun! VexOpen(dir)
    let g:netrw_browse_split=4
    execute "Vexplore " . a:dir
    let t:vex_buf_nr = bufnr("%")
endf

fun! VexClose()
    let cur_win_nr = winnr()
    let target_nr = (cur_win_nr == 1 ? winnr("#") : cur_win_nr)

    1wincmd w
    close
    unlet t:vex_buf_nr

    execute (target_nr - 1) . "wincmd w"
    "call NormalizeWidths()
endf

noremap <Leader>` :call VexToggle("")<CR>



" ------------------------------------------------------------------------------
" PLUGIN: CSV
" ------------------------------------------------------------------------------
filetype plugin on

" ------------------------------------------------------------------------------
" PLUGIN: AIRLINE
" ------------------------------------------------------------------------------
let g:airline_theme = "molokai"
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1
