;;; ~/.config/doom/config.el

;;; UI & CURSOR
(add-hook 'doom-after-init-hook (lambda () (blink-cursor-mode -1)))
(add-hook 'after-make-frame-functions (lambda (_) (blink-cursor-mode -1)))

(add-hook 'evil-insert-state-entry-hook (lambda () (blink-cursor-mode 1)))
(add-hook 'evil-insert-state-exit-hook  (lambda () (blink-cursor-mode -1)))

(with-eval-after-load 'shell
  (add-hook 'shell-mode-hook #'ansi-color-for-comint-mode-on)
  (setq comint-prompt-read-only t))

(unless (display-graphic-p)
  (add-hook 'evil-insert-state-entry-hook
            (lambda () (send-string-to-terminal "\e[5 q")))
  (add-hook 'evil-insert-state-exit-hook
            (lambda () (send-string-to-terminal "\e[2 q"))))

(setq evil-normal-state-cursor '(box "white")
      evil-insert-state-cursor '(bar "white")
      evil-visual-state-cursor '(hollow))

(setq display-line-numbers-type 'relative)
(setq doom-theme 'kanagawa-dragon)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Libre Baskerville" :size 14)
      doom-fixed-pitch-font (font-spec :family "JetBrains Mono" :size 14))

(setq org-agenda-files '("~/org/"))

;;; DISABLE MOUSE
(mouse-avoidance-mode nil)
(xterm-mouse-mode -1)
(dolist (k '([mouse-1] [mouse-2] [mouse-3]
             [down-mouse-1] [down-mouse-2] [down-mouse-3]
             [drag-mouse-1] [drag-mouse-2] [drag-mouse-3]
             [double-mouse-1] [triple-mouse-1]
             [wheel-up] [wheel-down] [wheel-left] [wheel-right]))
  (global-set-key k #'ignore))

;;; EDITOR BEHAVIOR
(setq scroll-margin 8)
(setq-default tab-width 2)
(setq typescript-indent-level 2)
(setq js-indent-level 2)
(setq css-indent-offset 2)

;;; KEYMAPPINGS
(map!
 :n "H" #'evil-first-non-blank
 :n "L" #'evil-end-of-line
 :v "H" #'evil-first-non-blank
 :v "L" #'evil-end-of-line

 :n "M-a" #'-whole-buffer
 :i "M-a" #'mark-whole-buffer
 :v "M-a" #'mark-whole-buffer

 :v "p" #'evil-paste-after

 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right

 :n "<C-up>"    #'evil-window-increase-height
 :n "<C-down>"  #'evil-window-decrease-height
 :n "<C-left>"  #'evil-window-decrease-width
 :n "<C-right>" #'evil-window-increase-width

 :n "C-d" (cmd! (evil-scroll-down 0) (evil-scroll-line-to-center nil))
 :n "C-u" (cmd! (evil-scroll-up 0)   (evil-scroll-line-to-center nil))

 :n "]c" #'git-gutter:next-hunk
 :n "[c" #'git-gutter:previous-hunk

 :n "s" #'avy-goto-char-2)
:v "g -" #'evil-numbers/dec-at-pt-incremental'
:v "g =" #'evil-numbers/inc-at-pt-incremental'

;;; LANGUAGE CONFIG
(after! lsp-mode
  (setq lsp-auto-guess-root t
        lsp-enable-symbol-highlighting t))

(after! hover
  (setq flutter-sdk-path "~/flutter"))

;;; WAYLAND INTEGRATION — fully isolated
(setq select-enable-clipboard nil
      select-enable-primary nil)

(when (not (display-graphic-p))
  (setq interprogram-cut-function
        (lambda (text &optional push)
          (let* ((process-connection-type nil)
                 (proc (start-process "wl-copy" nil "wl-copy")))
            (process-send-string proc text)
            (process-send-eof proc))))
  (setq interprogram-paste-function
        (lambda ()
          (when (executable-find "wl-paste")
            (let ((text (shell-command-to-string "wl-paste -n")))
              (unless (string-empty-p text) text))))))

(evil-define-operator +my/yank-to-clipboard (beg end type register yank-handler)
  "Yank the region or motion to the system clipboard."
  :move-point nil
  :repeat nil
  (interactive "<R><x><y>")
  (evil-yank beg end type ?+ yank-handler))

(map! :leader
      ;; Normal and Visual yank
      :desc "Yank to system"           :nv "y" #'+my/yank-to-clipboard
      ;; Normal mode paste
      :desc "Paste after from system"  :n  "v" (cmd! (evil-paste-after 1 ?+))
      :desc "Paste before from system" :n  "V" (cmd! (evil-paste-before 1 ?+))
      ;; Visual mode paste (replaces current selection beautifully)
      :desc "Paste over from system"   :v  "v" (cmd! (evil-visual-paste 1 ?+)))

;; ;; Device 1 is not a termcap terminal device : fix
;; (setq xterm-set-window-title t)
;; (defadvice! fix-xterm-set-window-title (&optional terminal)
;;   :before-while #'xterm-set-window-title
;;   (not (display-graphic-p terminal)))
