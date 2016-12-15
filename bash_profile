# .bashrc を読み込む
source ~/.bashrc

# history に関する設定
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoredups
# export HISTIGNORE="history*:hg*:cd*:pushd*:popd*:ls*:dirs*:fg*:bg*:quit*"
export HISTSIZE=10000

# プロンプトの編集
PS1='\[\033[01;32m\]\u:\W $ \[\e[0m\]'                         # default: PS1='\h:\W \u\$ '
# PS1='\[\e[0;36m\]\u:\W $ \[\e[0m\]'  # default: PS1='\h:\W \u\$ '
# PS2='>> '                            # default: PS2='> '
# \e[1;34m も好き
# 適切な位置に "\[" や "\]" を入れないと改行されなかったり変な文字が残るので注意
# http://pctonitijou.blog.fc2.com/blog-entry-243.html

# Homebrewのなんかよくわからない設定
PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH
# node path setting
export PATH=$HOME/.nodebrew/current/bin:$PATH
# js2coffee
export PATH=$PATH:~/node_modules/js2coffee/out/bin
