;;;Save this file in your home directory to get nicer emacs "look and feel"

;;Feel free to change any values or add/remove comment lines
;;(all lines starting with semicolon is a coment, like this line)

;;You can change the colors if you want

;;(require 'xcscope)
(tool-bar-mode nil)
;;(setq initial-frame-alist '((top . 0) (left . 0) (width . 124) (height . 47)))
(global-set-key '[(super v)] 'scroll-up)
(global-set-key (kbd "C-s-v") 'scroll-down)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(setq mouse-wheel-progressive-speed nil)




(load "paren")
;; Shows matching parentesis
(show-paren-mode 1)

(global-font-lock-mode t)                      ; Highlighting...
(setq font-lock-maximum-decoration t)          ; ...as much as possible...
;(setq font-lock-support-mode 'lazy-lock-mode)  ; ...in the background (?)...
;(setq lazy-lock-stealth-time 30)               ; ...after 30 seconds...
;(setq lazy-lock-stealth-verbose t)             ; ...and report doing so...
;(setq lazy-lock-defer-driven 1)                ; ...defer-driven "eventually".

;;Set up language environment (sweedish)
;;(set-language-environment "Latin-1")
;;(set-terminal-coding-system 'latin-1)

;; Scrollbar settings
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode 'right)

;; Basic colors
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color     "White")

;; Colors in Emacs 19.XX
;; Colors depending on emacs mode (C++ for example)
;;     (FACE FOREGROUND BACKGROUND BOLD-P ITALIC-P UNDERLINE-P)
(if (string-match "^19" emacs-version)
    (setq font-lock-face-attributes
	  '((font-lock-comment-face       "FireBrick"   nil nil t   nil)
	    (font-lock-function-name-face "Blue"        nil t   nil nil)
	    (font-lock-keyword-face       "Black"       nil t   nil nil)
	    (font-lock-string-face        "ForestGreen" nil nil t   nil)
	    (font-lock-type-face          "Blue"        nil nil nil nil)
	    (font-lock-variable-name-face "Black"       nil nil nil nil)
	    (font-lock-reference-face     "ForestGreen" nil nil nil nil))))


;; Colors in Emacs 20.XX
(if (string-match "^20" emacs-version)
    (progn
      (custom-set-variables)
      (custom-set-faces
       '(font-lock-comment-face ((((class color) (background light))
				  (:italic t :foreground "Firebrick"))))
       '(font-lock-function-name-face ((((class color) (background light))
					(:bold t :foreground "Blue"))))
       '(font-lock-keyword-face ((((class color) (background light))
				  (:bold t :foreground "Black"))))
       '(font-lock-string-face ((((class color) (background light))
				 (:italic t :foreground "ForestGreen"))))
       '(font-lock-type-face ((((class color) (background light))
			       (:foreground "Blue"))))
       '(font-lock-variable-name-face ((((class color) (background light))
					(:foreground "Black"))))
       '(font-lock-reference-face ((((class color) (background light))
				    (:foreground "ForestGreen")))))))

;; ----------------------------------------------------------------------------
;; Other useful stuff
;; ----------------------------------------------------------------------------

;; Handles characters with code 128+ (some swedish special chars)
(set-input-mode (car (current-input-mode))
                     (nth 1 (current-input-mode))
                     0)

;; Pressing Delete erase all marked text
(delete-selection-mode t)

;; Invert marked area
;;(transient-mark-mode t)

;; "Ctrl-RET" to extend a word
(global-set-key '[(control return)] 'dabbrev-expand)

;; Require explicit newline to add rows at end of file.
;; Avoids lot of empty rows last in file
(setq next-line-add-newlines nil)

;; Scroll only one row up or down
(setq scroll-step 3)
(setq scroll-conservatively 3)

;; Keep track of current row and column
(setq line-number-mode t)
(setq column-number-mode t)

;; Switch CR/LF will give indention on new lines
(setq foo (global-key-binding "\C-m"))              ; Save CF
(global-set-key "\C-m" (global-key-binding "\C-j")) ; CR = LF
(global-set-key "\C-j" foo)                         ; LF = old CR

;; F5 changes "line-wrap".
(global-set-key [f5] 'toggle-truncate-lines)

;; C++ specific
;; Treat *.h-filer as C++, not C
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
;; Good indentation style
(setq c-default-style "ellemtel")


;;Manually trying to solve scroll problem----failed
;;(global-set-key "\C-\M-)" 'scroll-down)
;;(global-set-key [mouse-5] 'scroll-up)


;;; For imwheel
;(setq imwheel-scroll-interval 5)
;(defun imwheel-scroll-down-some-lines ()
;  (interactive)
;  (scroll-down imwheel-scroll-interval))
;(defun imwheel-scroll-up-some-lines ()
;  (interactive)
;  (scroll-up imwheel-scroll-interval))
;(global-set-key [?\M-\C-\)] 'imwheel-scroll-up-some-lines)
;(global-set-key [?\M-\C-\(] 'imwheel-scroll-down-some-lines)
;;; end imwheel section


;;Modified from imwheel settings, scroll one page each time
;;(global-set-key [?\M-\C-\)] 'scroll-up)
;;(global-set-key [?\M-\C-\(] 'scroll-down)


;;Modified from imwheel settings and section before, doesn't work
;;(global-set-key [?\M-\C-\)] 'scroll-up 3)
;;(global-set-key [?\M-\C-\(] 'scroll-down 3)
;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
; '(column-number-mode t)
; '(cua-mode t nil (cua-base))
; '(fringe-mode (quote (nil . 0)) nil (fringe))
; '(inhibit-startup-screen t)
 '(printer-name "tn0706090bla")
; '(show-paren-mode t))
;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(delete-selection-mode nil)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
