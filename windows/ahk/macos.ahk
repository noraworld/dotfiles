; Switch applications with Command(Ctrl) + Tab (macOS-like)
Ctrl & Tab::AltTab
Ctrl & SC029::ShiftAltTab

; Take screenshot with Command(Ctrl) + Shift + 4 (macOS-like)
^+4::Send,#+s

; Open emoji palette with Command(Ctrl) + Ctrl(Alt) + Space (macOS-like)
^!Space::Send,#.

; Switch hankaku/zenkaku with Ctrl(Alt) + Space
;; https://yasushiito.hatenablog.com/entry/2019/03/15/183853
;; https://blog.goo.ne.jp/mocas_lab/e/3d1238365a243bb4614587076e159998
!Space::Send,{vkF3sc029}

; Emacs keybinds
;; https://qiita.com/digitarhythm/items/d5dcc1e714f794d26536
;; https://alfort728.hatenablog.com/entry/2019/03/29/041408
!p::Send,{Up}
!b::Send,{Left}
!n::Send,{Down}
!f::Send,{Right}
!a::Send,{Home}
!e::Send,{End}
!m::Send,{Enter}
!h::Send,{BS}
!d::Send,{Delete}

; For the terminal
!c::Send,^c
!l::Send,^l
!u::Send,^u

; Disable focusing to the menu bar in pressing the Alt key by itself
Alt::Return

Return
