execute pathogen#infect()

"" General settings
set nocompatible                " no compatibility with legacy vim
syntax enable
set synmaxcol=800               " don't try to highlight long lines
set encoding=utf-8              " set default encoding to utf-8
set showcmd                     " display incompatible commands
filetype plugin indent on       " load file type plugins + indentation
set textwidth=79
set colorcolumn=80
set cursorline                  " Highlight the screen line of the cursor with CursorLine
set relativenumber              " Show the line number relative to the line with the cursor.

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

set guioptions+=b               " Show horizontal scrollbar

let mapleader = ","
let maplocalleader = ","

"" Statusline
set laststatus=2                " always show statusline as 2nd last line

set statusline=                 " clear statusline when vimrc is reloaded
set statusline=%t               " tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]         " file format
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " read-only flag
set statusline+=%y              " filetype
set statusline+=%=              " left/right separator
set statusline+=%c,              " cursor column
set statusline+=%l/%L           " cursor line / total lines


"" Whitespace
set nowrap                      " don't wrap lines
set softtabstop=4 shiftwidth=4  " indent by 4 spaces when pressing tab 
set tabstop=8                   " tab character is still 8 spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set list                        " display whitespace characters
set listchars=tab:▸\ ,eol:¬

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " search are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Always search in 'very magic' mode
nnoremap / /\v
vnoremap / /\v

"" Mappings

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" jj to exit insert mode
inoremap jj <ESC>

" Force saving filed that require root permission
cmap w!! %!sudo tee > /dev/null %

"" Plugins

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
