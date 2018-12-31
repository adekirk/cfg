" .vimrc
" Author: Adrian Kirk
"

" Configure windows plugin path to .vim
if has("win32") || has("win64")
    set runtimepath^=~/.vim
    set runtimepath+=~/.vim/after
endif


set nocompatible                    " use Vim settings, not Vi settings

" -------------------------------------------------------------------------------
" COLORS
" -------------------------------------------------------------------------------
syntax on
color dracula
colorscheme default
set background=dark


" -------------------------------------------------------------------------------
" TABS, SPACES, INDENTATION
" -------------------------------------------------------------------------------
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


" Configuration {{{
set title                                               " set the window title reflecting current file
set number                                              " show line numbers
set relativenumber                                      " show relative line numbers
augroup toggle_relative_number                          " switch to absolute numbers is Insert Mode and revert back to relative numbers is Normal Mode
autocmd InsertEnter * :setlocal norelativenumber | set number
autocmd InsertLeave * :setlocal relativenumber
set showcmd                                             " show incomplete command in bottom bar
set wildmenu                                            " visual autocomplete for command menu
set lazyredraw                                          " only redraw when needed, not in macros
set showmatch                                           " highlight matching [{()}]
set noshowmode                                          " hide --INSERT-- in status, displayed in airline
set backspace=indent,eol,start                          " allow backspacing over intentation, line breaks and instert start.
set history=1000                                        " set big history of executed commands
set autoread                                            " automatically re-read files if unmodified inside Vim
set laststatus=2                                        " additional status line for airline
set tabpagemax=40                                       " maximum number of tab pages that can be opened from the commmand line
"set cursorline                                          " highlight the current line
"highlight CursorLine ctermbg=darkgrey
set exrc                                                " project specific .vimrc
"}}}

" -------------------------------------------------------------------------------
" SWAP AND BACKUP
" -------------------------------------------------------------------------------
set directory=$USERPROFILE/.vimfiles/swp//
set nobackup
set nowb


" Searching {{{
set hlsearch                                            " Highlight searsh results
set incsearch                                           " Set incremental search
set ignorecase                                          " ignore case when searching
" }}}
" Text Rendering {{{
set encoding=utf-8                                      " unicode
set scrolloff=3                                         " number of screen lines to keep above and below the cursor
set sidescrolloff=5                                     " number of screen columns to keep left and right of the cursor
syntax enable                                           " enable syntax processing
" }}}
" ESC hides search highlight {{{
noremap <silent> <ESC> :nohlsearch<BAR>:echo<CR>
" }}}
" Syntax {{{
filetype on                                             " syntax highlight based on file extension
" }}}
" Mapping {{{
inoremap jk <ESC>

" move between buffers
map <C-J> <ESC>:bprev<CR>
map <C-K> <ESC>:bnext<CR>

" switch to left / right split (mostly for netrw)
map <C-h> <C-W>h
map <C-l> <C-W>l

" }}}
" Misc {{{
let mapleader = "\<space>"
map <leader>s :source ~\.vimrc<CR>                      " \s reloads .vimrc
" }}}
" Folding {{{
set foldenable              " enable folding
set foldlevel=10            " open upto 10 levels by default
set foldnestmax=10          " 10 nested folds max
set foldmethod=indent       " fold based on indent

nnoremap <space> za
" }}}
" netrw {{{
let g:netrw_liststyle = 1       " Explorer list style = Detailed
let g:netrw_banner = 1          " Hide banner
let g:netrw_browse_split = 4    " Load file in split and keep netrw
let g:netrw_winsize = 33        " 33%

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
" }}}

" csv {{{
filetype plugin on
" }}}

" airline {{{
"let g:airline_theme = 'wombat'
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#branch#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:airline_section_z = airline#section#create_right(['%l','%c'])
" }}}


" vim:foldmethod=marker:foldlevel=0
