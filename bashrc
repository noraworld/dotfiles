# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases
alias open='xdg-open'               # open command
alias run='./a.out'                 # execute C binary
alias quit='exit'                   # type quit to exit
alias logout='exit'                 # type logout to exit
alias rm='echo cannot execute: rm ' # cannot execute
alias shell='exec $SHELL'           # reboot shell(-lオプション必要？)
alias la='ls -a'                    # list with secret files
alias lal='ls -la'                  # list in detail with secret files
alias lla='ls -la'                  # list in detail with secret files

# User specific functions

## reference external manual
function ual() {
# 引数がない場合はマニュアル一覧を表示して終了する
if [ ! $# -ne 0 ]; then
  echo "What external manual page do you want?"
  ls -1 ~/Memorandum/
  return
fi
# 複数の引数がある場合は再帰的に実行する
for arg in $@
do
  # 引数に.txtを付与する
  manualname=${arg}.txt
  # 外部マニュアルを参照する
  less ~/Memorandum/${manualname}
done
}

## move to trash
function trash() {
# 引数がない場合は警告して終了
if [ ! $# -ne 0 ]; then
  echo "trash: missing file operand"
  echo "詳しくは \`trash --help' を実行して下さい."
  return
fi
# 複数の引数(ゴミ箱に移動する複数のファイル)がある場合は再帰的に実行
for arg in $@
do
  # ファイルパスからファイル名だけを抽出(ex: hoge/huga/piyo.txt => piyo.txt)
  filename=${arg##*/}
  # フルパスの設定
  istrash="~/.local/share/Trash/files/${filename}"
  # count の初期化
  count=0
  # ゴミ箱に同名ファイルが存在しなくなるまで
  while [ -e ${istrash} ]
  do
    # count をインクリメント
    count=`expr $count + 1`
    # [ex: piyo.txt.old(countの値)] が存在しない場合は
    if [ ! -e "${istrash}.old$count" ]; then
      # ゴミ箱内の [ex: piyo.txt] を [ex: piyo.txt.old(countの値)] に置き換える
      mv ${istrash} "${istrash}.old$count"
      # 置き換えたことを通知する
      echo "trash: 同名のファイルがゴミ箱に存在します"
      echo "trash: ゴミ箱内の ${filename} を ${filename}.old$count に変更しました"
    fi
  done
  # ゴミ箱に移動する
  mv ${arg} ~/.local/share/Trash/files
done
}

## execute commands when boot terminal
if [ $SHLVL = 2 ]; then
  # .parentlock が存在すればゴミ箱に移動する
  parentlock="~/.mozilla/firefox/i736vk63.default/.parentlock"
  if [ -e ${parentlock} ]; then
    \rm ~/.mozilla/firefox/i736vk63.default/.parentlock
    echo "shell: .parentlock を削除しました"
  fi
  # lock が存在すればゴミ箱に移動する
  lock="~/.mozilla/firefox/i736vk63.default/lock"
  if [ -L ${lock} ]; then
    \rm ~/.mozilla/firefox/i736vk63.default/lock
    echo "shell: lock を削除しました"
  fi
  # ちゃんと削除できているかチェックする
  echo "~/.mozilla/firefox/i736vk63.default/"
  ls -la ~/.mozilla/firefox/i736vk63.default/ | grep lock
fi
