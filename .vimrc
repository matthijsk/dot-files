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

filetype indent on

filetype plugin on         " Enable filetype plugins (omnicompletion!)
runtime! ftplugin/man.vim  " Access man pages in a vim window (:Man <subject>)

if &diff
  colorscheme xoria256
else
  if has("gui_running")
    colorscheme wombat
    " Only map CTRL-S to :write when running GUI, C-S in a terminal will pause it.
    nnoremap <C-S> :write<CR>
  else
    colorscheme wombat256
  endif
endif

" Disable toolbar and menubar, but leave the rest of the defaults.
set guioptions+=c       " Use console dialogs
set guioptions-=e       " No tab pages
set guioptions-=m       " Remove menu
set guioptions-=T       " Remove toolbar
set guioptions-=r       " Don't display right-hand scrollbar
set guioptions-=L       " Don't display left-hand scrollbar
set guioptions-=b       " No bottom scrollbar

set guifont=Terminus

set laststatus=2

let g:SuperTabDefaultCompletionType = "context"

let mapleader = ","

nmap <Leader>e :edit ~/.vimrc<CR>
nmap <Leader>s :source ~/.vimrc<CR>

nmap <Leader>l :ListToggle<CR>
nmap <Leader>m :make<CR>

nmap <Leader>tn :tabnew<CR>
nmap <Leader>tc :tabclose<CR>

" Map F2 to clist (overview of compiler errors/warnings)
nmap <F2> :clist<CR>

" Toggle quickfix list
nmap <F3> :Ctoggle<CR>

nmap <F4> :call ContextSearch()<CR>

" Search for word in current buffer
nmap <F5> :execute "vimgrep /\\C" . expand("<cword>") . "/j" . expand("%")<CR>

nmap <F6> :A<CR>

nnoremap <Tab> <C-W>w
nnoremap K :execute "Man " . expand("<cword>")<CR>

command! ListToggle :call ToggleSetList()

function! ToggleSetList()
  if &list
    set nolist
  else
    set list
  endif
endfunction

command! Ltoggle :call QuickfixToggle('l')
command! Ctoggle :call QuickfixToggle('c')

function! QuickfixToggle(type)
  if a:type == 'c'
    let l:closecommand = 'cclose'
    let l:opencommand = 'botright copen'

    let l:bnum = winbufnr(winnr())
    if getbufvar(l:bnum, '&buftype') != 'quickfix'
      let l:prevwinnr = ''
    else
      let l:prevwinnr = winnr('#') . "wincmd w"
    endif
  elseif a:type == 'l'
    let l:closecommand = 'lclose'
    let l:opencommand = 'lopen'
    let l:prevwinnr = ''
  else
    throw "invalid argument: use \'c\' or \'l\'"
  endif

  for i in range(1, winnr('$'))
    let l:bnum = winbufnr(i)
    if getbufvar(l:bnum, '&buftype') == 'quickfix'
      execute l:closecommand
      execute l:prevwinnr
      return
    endif
  endfor

  execute l:opencommand
endfunction

function! ContextSearch()
  let l:cwd = fnamemodify(getcwd(), ":t")
  let l:word = expand("<cword>")

  call CustomVimGrep(l:word, "**", 0)
endfunction

function! CustomVimGrep(word, path, append)
  if a:append
    let l:vimgrep = "vimgrepadd /\\C"
  else
    let l:vimgrep = "vimgrep /\\C"
  endif

  try
    execute l:vimgrep . a:word . "/j " . a:path
  catch /E480:/
    echo a:word . " not found in " . a:path
  endtry
endfunction