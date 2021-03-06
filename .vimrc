execute pathogen#infect()

" General settings {{{
set nocompatible                " no compatibility with legacy vim
syntax enable
set synmaxcol=800               " don't try to highlight long lines
set encoding=utf-8              " set default encoding to utf-8
set showcmd                     " display incompatible commands
filetype plugin indent on       " load file type plugins + indentation
set textwidth=79
set colorcolumn=80
set cursorline                  " Highlight the screen line of the cursor with CursorLine
set relativenumber              " Show the line number relative to the line with the cursor
set number                      " Show the absolute line number for the current line
set clipboard=unnamed           " Use the os clipboard

" Spaces & Tabs {{{
set softtabstop=4 shiftwidth=4  " indent by 4 spaces when pressing tab
set tabstop=8                   " tab character is still 8 spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set list                        " display whitespace characters
set listchars=tab:▸\ ,eol:¬
" }}}

" Line wrap {{{
set nowrap                      " don't wrap lines
" }}}

" Look and feel {{{
if has('gui_running')
    set background=light
    set guifont=Menlo\ for\ Powerline
else
    set background=dark
endif
colorscheme solarized

set guioptions+=b               " Show horizontal scrollbar

set synmaxcol=1200              " Don't color long lines

if exists('$ITERM_PROFILE')     " make tmux update the cursor shape
    if exists('$TMUX')
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[0 q"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
end
" }}}

" Folding {{{
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10              " max 10 depth
set nofoldenable                " don't fold files by default on open
set foldlevelstart=1            " start with fold level of 1
" }}}


let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
" }}}

" Statusline {{{
set laststatus=2                " always show statusline as 2nd last line
" }}}

" Searching {{{
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " search are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Always search in 'very magic' mode
nnoremap / /\v
vnoremap / /\v
" }}}

" Mappings {{{

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" jj to exit insert mode
inoremap jj <ESC>

" Map : to ; and ; to , in normal mode
nore ; :
nore , ;

" Disable ex-mode
nnoremap Q <nop>

" Map frequently used actions to Leader
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V

" Simpler movement to specific line
nnoremap <CR> G
nnoremap <BS> gg

" Quicker buffer selection
nnoremap <Leader>g :e#<CR>

let c = 1
while c <= 9
    execute "nnoremap \<Leader>" . c . " :" . c . "b\<CR>"
    let c += 1
endwhile
nnoremap <Leader>0 :10b<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

" tab through buffers
nnoremap <Leader><Tab> :bnext<CR>
nnoremap <Leader><S-Tab> :bprevious<CR>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" Force saving filed that require root permission
cmap w!! %!sudo tee > /dev/null %
" }}}

" Tags {{{
setglobal tags=./tags;
" }}}

" Languages {{{

" Python
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" Markdown instead of modula2
autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell textwidth=0 wrapmargin=0
" }}}

" Plugins {{{

" --- ctrlp ---
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" speed up Ctrl-P in Git projects
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
endif

" --- airline ---
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 1

" --- MiniBufExpl ---
map <Leader>d :MBEbd<cr>

" --- gitgutter ---
" Require after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display 'hunks' if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" --- NERDTree ---
map <Leader>n :NERDTreeToggle<CR>
" close vim if NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" --- Fugitive ---
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>
" vimdiff current vs git head
nnoremap <Leader>gd :Gdiff<CR>
" switch back to current file and closes fugitive buffer
nnoremap <Leader>gD <c-w>h<c-w>c
nnoremap <Leader>ge :Gedit<CR>

" --- Syntastic ---
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_exec = 'RBENV_VERSION=system ruby'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:syntastic_javascript_checkers = ['eslint']

nnoremap <Leader>c :SyntasticCheck<CR>
" --- Ack.vim ---
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
nnoremap K :Ack "<C-R><C-W>"<CR>

" --- Quick Scope --- "
" only enable quick highlighting when using f/F/t/T movements
" https://gist.github.com/cszentkiralyi/dc61ee28ab81d23a67aa
let g:qs_enable = 0
let g:qs_enable_char_list = [ 'f', 'F', 't', 'T' ]

function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif
    let letter = nr2char(getchar())
    if needs_disabling
        QuickScopeToggle
    endif
    return a:movement . letter
endfunction

for i in g:qs_enable_char_list
    execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor
" }}}

" vim:foldmethod=marker:foldlevel=0
