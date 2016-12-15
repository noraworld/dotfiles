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

## 既存のコマンド名を使用する場合はcommandを付与すること
# gcc hoge.c で hoge という実行ファイルを作成
# function gcc() {
#   out=`echo $1 | awk -F '.' '{print $1}'`
#   command gcc -w -o ${out} $1 $2
# }

# CotEditor の環境設定
# function cot() {
#   touch $1
#   command cot $1
# }

# tmux や screen を使うときに history を共有する
# function share_history {  # 以下の内容を関数として定義
# history -a  # .bash_historyに前回コマンドを1行追記
# history -c  # 端末ローカルの履歴を一旦消去
# history -r  # .bash_historyから履歴を読み込み直す
# }
# shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
# export HISTSIZE=9999  # 履歴のMAX保存数を指定
#
# PROMPT_COMMAND="share_history"  # 上記関数をプロンプト毎に自動実施
