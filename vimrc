" Load other config files
runtime! config/*.vim

" Set configs
scriptencoding utf-8
set encoding=utf-8
set number
set title
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:*,eol:$,extends:»,precedes:«,nbsp:%
set virtualedit=block
set ignorecase
set hlsearch
set virtualedit=onemore

" Key bindings like Emacs
"" Normal mode + Visual mode
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <C-a> <Home>
noremap! <C-e> <End><Right>
noremap! <C-n> <Down>
noremap! <C-p> <Up>

"" Commandline mode + Insert mode
noremap <C-f> <Right>
noremap <C-b> <Left>
noremap <C-a> <Home>
noremap <C-e> <End><Right>
noremap <C-n> <Down>
noremap <C-p> <Up>

" Syntax highlight on
if has("syntax")
  syntax on
endif

" Syntax highlight color
hi LineNr     ctermfg=cyan
hi Comment    ctermfg=darkgrey
hi NonText    ctermfg=lightgrey
hi SpecialKey ctermfg=lightgrey

" Cursor shape
let &t_ti.="\e[4 q"
let &t_SI.="\e[4 q"
let &t_EI.="\e[4 q"
let &t_te.="\e[0 q"
