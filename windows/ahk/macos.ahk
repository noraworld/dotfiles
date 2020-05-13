; Switch applications with Command(Ctrl) + Tab (macOS-like)
Ctrl & Tab::AltTab
Ctrl & SC029::ShiftAltTab

; Take screenshot with Command(Ctrl) + Shift + 4 (macOS-like)
^+4::Send,#+s

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

; for terminal
!c::Send,^c
!l::Send,^l
!u::Send,^u

; Disable focusing to the menu bar in pressing the Alt key by itself
Alt::Return

Return