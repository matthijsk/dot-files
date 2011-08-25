set ruler               " Set ruler (line, column) in lower right of screen
set showcmd             " Show partial commands in bottom of screen
set incsearch           " Display match for search pattern when halfway typing it

set scrolloff=5         " Keep 5 lines of context when scrolling

set expandtab           " No real tabs
set shiftwidth=2        " Indentation 2 spaces
set softtabstop=2
set tabstop=4           " Real tabs should be 4.

set ignorecase          " Case insensitive by default
set smartcase           " But enable case sensitivity when a capital letter is typed anyway
set nowrap              " No line wrapping

set autoindent          " Auto indentation
set smartindent         " Keep indentation of previous line

syntax enable           " Syntax highlighting

set wildmenu            " Menu tabcompletion

filetype plugin on      " Enable filetype plugins (omnicompletion!)
runtime! ftplugin/man.vim  " Access man-pages in a vim window (:Man <subject>)

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