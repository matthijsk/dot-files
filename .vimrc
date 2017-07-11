scriptencoding utf-8    " Set encoding to UTF-8

set backspace=indent,eol,start " Make backspace behave like it should
set ruler               " Set ruler (line, column) in lower right of screen
set showcmd             " Show partial commands in bottom of screen
set incsearch           " Display match for search pattern when halfway typing it

set scrolloff=5         " Keep 5 lines of context when scrolling

set expandtab           " No real tabs
set shiftwidth=4        " Indentation 4 spaces
set softtabstop=4
set tabstop=8           " Real tabs should be 8

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

colorscheme evening

" Disable toolbar and menubar, but leave the rest of the defaults.
set guioptions+=c       " Use console dialogs
set guioptions-=e       " No tab pages
set guioptions-=m       " Remove menu
set guioptions-=T       " Remove toolbar
set guioptions-=r       " Don't display right-hand scrollbar
set guioptions-=L       " Don't display left-hand scrollbar
set guioptions-=b       " No bottom scrollbar

set guifont=Terminus\ 12

set laststatus=2

if has ("gui_running")
    " Maximize window
    set lines=999
    set columns=999
    " Make all windows equally high and wide
    execute "normal <C-W>="
endif

" Remap , so it can be used as leader.
nnoremap \ ,
let mapleader = ","

nmap <Leader>e :edit ~/.vimrc<CR>
nmap <Leader>s :source ~/.vimrc<CR>

nmap <Leader>l  :set list!<CR>
nmap <Leader>rl :set relativenumber!<CR>
nmap <Leader>hl :set cursorline!<CR>

nmap <Leader>m :make<CR>

nmap <Leader>tn :tabnew<CR>
nmap <Leader>tc :tabclose<CR>

nmap <Leader>ww <C-W>w
nmap <Leader>ws :split<CR>
nmap <Leader>wv :vsplit<CR>
nmap <Leader>wc :close<CR>
nmap <Leader>wo :only<CR>

nmap <Leader>bd :bdelete<CR>

" Yank current selection into clipboard in visual mode
vmap <Leader>c "*y
" Put current clipboard content
nmap <Leader>v "*p
" Yank entire file to clipboard
nmap <Leader>a :%y*<CR>

" Map F2 to clist (overview of compiler errors/warnings)
nmap <F2> :clist<CR>

" Toggle quickfix list
nmap <F3> :Ctoggle<CR>

nmap <F4> :call ContextSearch()<CR>

" Search for word in current buffer
nmap <F5> :execute "vimgrep /\\C" . expand("<cword>") . "/j" . expand("%")<CR>

nmap <F6> :A<CR>

" Scroll up and down using space and backspace in normal mode.
nnoremap <Space> <C-D>
nnoremap <BS>    <C-U>

" Switch windows with tab.
nnoremap <Tab>  <C-W>w

nnoremap K      :execute "Man " . expand("<cword>")<CR>

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
