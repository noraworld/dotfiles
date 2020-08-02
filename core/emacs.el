;; 起動時のメッセージを表示しない
;; 「t」を「nil」にするとメッセージが表示される
(setq inhibit-startup-message t)

(unless window-system (menu-bar-mode nil))

;; * バックアップファイルを作成しない
(setq make-backup-files nil)

;; # バックアップファイルを作成しない
(setq auto-save-default nil)

(setq-default c-basic-offset 2)

;; EmacsのWindowを一番上に表示
(if (eq window-system 'ns)
    (x-focus-frame nil))


;; Mac用フォント設定
;; http://tcnksm.sakura.ne.jp/blog/2012/04/02/emacs/

 ;; 英語
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
             :height 150)    ;; font size

;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
;;これをアクティブに ;;(setq face-font-rescale-alist
;;これは使わない ;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
;;これをアクティブに ;;      '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定

;; 文字の色を設定する
(add-to-list 'default-frame-alist '(foreground-color . "white"))
;; 背景色を設定する
(add-to-list 'default-frame-alist '(background-color . "black"))

;; 背景を半透明にする
;;(setq default-frame-alist
;;      (append (list
;;	       '(alpha . (55 55)) ;; 初期設定の値は(65 65)
;;	       ) default-frame-alist))

;; 背景を半透明にする
(if window-system (progn
    (set-background-color "Black")
    (set-foreground-color "LightGray")
    (set-cursor-color "Gray")
    (set-frame-parameter nil 'alpha 90) ;; 55でいい感じの透明度になる
))

;; 背景を半透明にする(M-x後にalphaで透明度変更可能)
(defun alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))


(if (boundp 'window-system)
    (setq default-frame-alist
        (append (list
            '(left . 718)  ;; 起動時のウィンドウの表示位置(※1)
	    '(width . 78)  ;; 起動時のウィンドウの幅(※2)
	    '(height . 47) ;; 起動時のウィンドウの高さ
        )
        default-frame-alist)))
;; (※1) 幅79のときは709, 幅78のときは718
;; (※2) 79でターミナルと同じ
;;       78でちょうど画面の半分(スクロールバー含めない, MacBook Airの場合)
