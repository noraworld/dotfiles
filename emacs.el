;;
;; .emacs.el
;;
;; Emacs から読まれるファイル

;; 日本語で使う
(set-language-environment "Japanese")

;; 日本語入力システムanthyの設定
(setq default-input-method "japanese-anthy") 

;; テキストエンコーディングとしてUTF-8を優先的に使用する
(prefer-coding-system 'utf-8)

;; 起動時のメッセージを表示しない
;;「t」を「nil」にするとメッセージが表示される
(setq inhibit-startup-message t)

;; font-lock モードを使う
(global-font-lock-mode t)

;; ファイルの最後は改行を必要とする
(setq require-final-newline t)

;; 最後の行で next-line を実行しても新しい行を追加しない
(setq next-line-add-newlines nil)

;; -nw の時、メニューバーを消す
;(unless window-system (menu-bar-mode nil))

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(if window-system (progn

  ;; 文字の色を設定します。
  (add-to-list 'default-frame-alist '(foreground-color . "white"))
  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "black"))
  ;; カーソルの色を設定します。
  ;; (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
  ;; マウスポインタの色を設定します。
  ;; (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
  ;; モードラインの文字の色を設定します。
  ;; (set-face-foreground 'modeline "white")
  ;; モードラインの背景色を設定します。
  ;; (set-face-background 'modeline "black")
  ;; 選択中のリージョンの色を設定します。
  ;; (set-face-background 'region "LightSteelBlue1")
  ;; モードライン（アクティブでないバッファ）の文字色を設定します。
  ;; (set-face-foreground 'mode-line-inactive "gray30")
  ;; モードライン（アクティブでないバッファ）の背景色を設定します。
  ;; (set-face-background 'mode-line-inactive "gray85")

))

;; 起動時のウィンドウサイズを変更する(デフォルトは80 x 40)
;;(setq initial-frame-alist
;;'((top . 0) (left . 2000) (width . 75) (height . 51)))

;; スクロールバーを右側に表示する
(set-scroll-bar-mode 'right)

;; 透明度を変更する, コマンドM-x, set-alpha, 数値
;;(defun set-alpha (alpha-num)
;;"set frame parameter 'alpha"
;;(interactive "nAlpha: ")
;;(set-frame-parameter nil 'alpha (cons alpha-num '(90))))

;;(set-frame-parameter nil 'alpha 70)

(setq ps-multibyte-buffer 'non-latin-printer)
(require 'ps-mule)
(defalias 'ps-mule-header-string-charsets 'ignore)
