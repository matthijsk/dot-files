scriptencoding utf-8    " Set encoding to UTF-8

set backspace=indent,eol,start " Make backspace behave like it should
set ruler               " Set ruler (line, column) in lower right of screen
set showcmd             " Show partial commands in bottom of screen
set incsearch           " Display match for search pattern when halfway typing it

set scrolloff=5         " Keep 5 lines of context when scrolling

set expandtab           " No real tabs
set shiftwidth=2        " Indentation 2 spaces
set softtabstop=2
set tabstop=4           " Real tabs should be 4

set ignorecase          " Case insensitive by default
set smartcase           " But enable case sensitivity when a capital letter is typed anyway
set nowrap              " No line wrapping

set autoindent          " Auto indentation
set smartindent         " Keep indentation of previous line

syntax enable           " Syntax highlighting

set wildmenu            " Menu tabcompletion

set diffopt+=iwhite     " Ignore whitespace when diffing

set textwidth=78        " Set default textwidth of 78

filetype plugin on      " Enable filetype plugins (omnicompletion!)
runtime! ftplugin/man.vim  " Access man pages in a vim window (:Man <subject>)

" Terminal supports more than 256 colors or gvim running?
if &t_Co == 256 || has("gui_running")
  set t_Co=256          " 256 color terminal support
  colorscheme xoria256  " Default colorscheme
endif

" Disable toolbar and menubar, but leave the rest of the defaults.
set guioptions-=m       " Remove menu
set guioptions-=T       " Remove toolbar
set guioptions-=r       " Don't display right-hand scrollbar
set guioptions-=L       " Don't display left-hand scrollbar

set guifont=Terminus    " Set the (awesome, might I add) Terminus font

" Use custom eol and tab characters
set listchars=eol:¶,tab:▸\ 

" Set SuperTab context completion
let g:SuperTabDefaultCompletionType = "context"

" Set leader key to , instead of \
let mapleader = ","

if has("gui_running")
  " Map CTRL-S to :write
  nnoremap <C-S> :write<CR>
endif

" Map F2 to clist (overview of compiler errors/warnings)
nmap <F2> :clist<CR>

" Map F3 to copen (quickfix window with compiler output)
nmap <F3> :copen<CR>

" Map F4 to vimgrep <current word> in the specified directory. TODO: make pwd
" dependent.
nmap <F4> :execute "vimgrep /\\C" . expand("<cword>") . "/ Sources/**"<CR>

" Map F6 to :A (alternate plugin, switch between header and source file)
nmap <F6> :A<CR>

" Map <leader>g to eclim (plugin) context search (all references)
nnoremap <leader>g :CSearch -x all<CR>

" Map CTRL-B to :make
nnoremap <C-B> :make<CR>

" Map <Tab> to CTRL-W w (switch window)
nnoremap <Tab> <C-W>w

