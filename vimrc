" Set configs
set number
set title
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set virtualedit=block
set smartcase
set hlsearch

" Key bindings like Emacs
map <C-f> <Right>
map <C-b> <Left>
map <C-a> <Home>
map <C-e> <End>
map <C-n> <Down>
map <C-p> <Up>

" Syntax highlight on
if has("syntax")
  syntax on
endif

" Syntax highlight color
highlight Comment ctermfg=grey
