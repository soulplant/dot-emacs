(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; (eval-when-compile
;;   (require 'use-package))

(setq inhibit-startup-screen t)

(use-package cider :ensure t)

(use-package lispy
  :ensure t
  :config)


(global-display-line-numbers-mode)



(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk")
  (add-to-list 'evil-escape-inhibit-functions 'region-active-p)
  (add-to-list 'evil-escape-inhibit-functions 'lispy-left-p)
  (add-to-list 'evil-escape-inhibit-functions 'lispy-right-p))

(use-package treemacs
  :ensure t)

(use-package lispyville
  :ensure t
  :config)

(use-package avy
  :ensure t
  :config
  (avy-setup-default)
  (global-set-key (kbd "C-:") 'avy-goto-char))

; (use-package lispyville
;   :ensure t
;   :hook (lispy-mode)
;   :init
;   (setq lispyville-key-theme
; 	'((operators normal)
; 	  c-w
; 	  (prettify insert)
; 	  (atom-movement t)
; 	  slur/barf-lispy
; 	  additional
; 	  additional-insert)))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package clojure-mode
  :ensure t
  :config
  (show-paren-mode))

(use-package company
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package magit
  :ensure t)

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package rainbow-delimiters
  :ensure t)

(with-eval-after-load 'evil-maps
  (define-key evil-insert-state-map (kbd "C-t") nil)
  (define-key evil-insert-state-map (kbd "C-e") nil)
  (define-key evil-insert-state-map (kbd "C-a") nil)
  (define-key evil-insert-state-map (kbd "C-k") nil)
  (define-key evil-insert-state-map (kbd "C-d") nil)
  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-insert-state-map (kbd "C-p") nil))

(use-package undo-tree
  :ensure t
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode))

(use-package counsel
  :ensure t
  :config
  (counsel-mode))

(use-package git-gutter
  :ensure t
  :config
  (git-gutter-mode))

;(use-package evil-collection
;  :after evil
;  :ensure t
;  :config
;  (evil-collection-init))

(ivy-mode)

(add-hook 'evil-mode-hook
	  (lambda ()
	    (evil-escape-mode)))

(add-hook 'clojure-mode-hook
	  (lambda ()
	    (lispy-mode)
	    (company-mode)))

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (evil-mode)
	    (lispy-mode)
	    (company-mode)))

;; (unless (package-installed-p 'cider)
;;   (package-install 'cider))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(package-selected-packages
   '(git-gutter which-key whichkey evil-escape undo-tree rainbow-delimiters gruvbox-theme magit company lispyville evil-collection evil lispy cider use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
