

(eval-after-load "package"
  '(add-to-list 'package-archives
    '("user42" . "http://download.tuxfamily.org/user42/elpa/packages/")))

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Rnw-mode-hook nil)
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (firecode)))
 '(custom-safe-themes
   (quote
	("1934bf7e1713bf706a9cb36cc6a002741773aa42910ca429df194d007ee05c67" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "7dd515d883520286fc8936ce32381fb01b978d0d7cfb6fe56f7f55d8accbf63a" default)))
 '(inhibit-startup-screen t)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))


(add-hook 'window-configuration-change-hook (lambda () (ruler-mode 1)))

(require 'auto-complete)

(setq ess-use-auto-complete 'script-only)

(define-key ac-completing-map "\M-n" nil) ;; was ac-next
(define-key ac-completing-map "\M-p" nil) ;; was ac-previous
(define-key ac-completing-map "\M-," 'ac-next)
(define-key ac-completing-map "\M-k" 'ac-previous)

(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)

(define-key ac-completing-map [tab] 'ac-complete)
(define-key ac-completing-map [return] nil)

;; multiple-cursors.el
(add-to-list 'load-path "~/.emacs.d/plugins/multiple-cursors.el")
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-,") 'mc/mark-all-like-this)
(global-set-key (kbd "C-.") 'mc/mark-more-like-this-extended) 
