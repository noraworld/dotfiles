alias sudo='sudo '
alias ls='ls -G'
alias dirs='dirs -v'
alias history='history | tail -r | less'
# alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias trash='rmtrash'
# alias man='env LANG=C man'
# alias jman='env LANG=ja_JP.UTF-8 man'
alias hg='history | grep'
alias ld='echo ERROR: cannot execute ld'
alias grep='grep --color=auto'

# プロンプトの編集
PS1='\[\033[01;32m\]\u:\W $ \[\e[0m\]'                         # default: PS1='\h:\W \u\$ '
# PS1='\[\e[0;36m\]\u:\W $ \[\e[0m\]'  # default: PS1='\h:\W \u\$ '
# PS2='>> '                            # default: PS2='> '
# \e[1;34m も好き
# 適切な位置に "\[" や "\]" を入れないと改行されなかったり変な文字が残るので注意
# http://pctonitijou.blog.fc2.com/blog-entry-243.html

# Homebrewのなんかよくわからない設定
PATH=/usr/local/bin:/usr/local/sbin:$PATH
# node path setting
#PATH=$HOME/.nodebrew/current/bin:$PATH
