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
set cursorline

" Key bindings like Emacs
"" Normal mode + Visual mode
noremap <C-f> <Right>
noremap <C-b> <Left>
noremap <C-a> <Home>
noremap <C-e> <End><Right>
noremap <C-n> <Down>
noremap <C-p> <Up>

"" Commandline mode + Insert mode
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <C-a> <Home>
noremap! <C-e> <End><Right>
noremap! <C-n> <Down>
noremap! <C-p> <Up>
noremap! <C-c> <Right><Esc>

" Syntax highlight on
if has("syntax")
  syntax on
endif

" Syntax highlight color
hi LineNr     ctermfg=cyan
hi Comment    ctermfg=darkgrey
hi NonText    ctermfg=lightgrey
hi SpecialKey ctermfg=lightgrey
"" Not work. Need to change the terminal preferences
"" Cursor color in preferences: R: 53, G: 125, B: 79
" hi Cursor ctermbg=15 ctermfg=8
hi CursorLine ctermbg=17

" Cursor shape
let &t_ti.="\e[2 q"
let &t_SI.="\e[4 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"
