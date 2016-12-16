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
"" Normal mode + Visual mode
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-n> <Down>
noremap! <C-p> <Up>

"" Commandline mode + Insert mode
noremap <C-f> <Right>↲
noremap <C-b> <Left>↲
noremap <C-a> <Home>↲
noremap <C-e> <End>↲
noremap <C-n> <Down>↲
noremap <C-p> <Up>↲

" Syntax highlight on
if has("syntax")
  syntax on
endif

" Syntax highlight color
highlight Comment ctermfg=grey
