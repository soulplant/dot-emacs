(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(tool-bar-mode -1)

;; (eval-when-compile
;;   (require 'use-package))

(autoload 'fennel-mode "/Users/james/.emacs.d/fennel-mode.el" nil t)
(add-to-list 'auto-mode-alist '("\\.fnl\\'" . fennel-mode))

(setq inhibit-startup-screen t)
(setq visible-bell t)

(use-package org
  :mode (("\\.org$" . org-mode))
  ;; :ensure org-plus-contrib
  :config
  (progn
    ;; TODO
    ))


(defun integrant-reset ()
  (interactive)
  (cider-interactive-eval "(integrant.repl/reset)"))

(defun integrant-halt ()
  (interactive)
  (cider-interactive-eval "(integrant.repl/halt)"))

(use-package cider
  :after evil
  :ensure t
  ;; :config
  ;; (with-eval-after-load 'evil-maps
  ;;   (define-key evil-normal-state-map (kbd "K") 'cider-doc))
  :bind
  ("C-c r" . (lambda () "integrant/reset"
	       (interactive)
	       (cider-interactive-eval "(integrant.repl/reset)")))
  ("C-c g" . (lambda () "integrant/go"
	       (interactive)
	       (cider-interactive-eval "(integrant.repl/go)")))
  :config
  (defun save-and-cider-load-buffer ()
    (interactive)
    (save-buffer)
    (cider-load-buffer))
  (evil-make-intercept-map cider--debug-mode-map 'normal)

  :bind (:map cider-mode-map
	      ("s-r" . save-and-cider-load-buffer)))

(use-package lispy
  :ensure t
  :config
  ;; This is necessary to prevent the "Lisp expression" prompt from
  ;; appearing randomly.
  ;; Taken from https://github.com/abo-abo/lispy/issues/418.
  (setq completion-at-point-functions
	(delq 'lispy-clojure-complete-at-point completion-at-point-functions)))

;; (global-display-line-numbers-mode)

;; We don't turn this on because it makes cursor movement really slow.
;; (setq display-line-numbers-type 'relative)
;; (setq display-line-numbers-type t)
(display-line-numbers-mode)
(setq auto-save-default nil)
(setq make-backup-files nil)


(global-set-key (kbd "s-[") 'previous-error)
(global-set-key (kbd "s-]") 'next-error)

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

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

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

(use-package flycheck-clj-kondo
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (show-paren-mode)
  (require 'flycheck-clj-kondo)
  (put-clojure-indent '>defn :defn)
  (put-clojure-indent '>def :defn)
  ;; (setq cider-format-code-options '(("indents"
  ;; 				     ((">defn" (("inner" 0)))
  ;; 				      (">def" (("inner" 0)))))))
  )

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings)
  )

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
  (define-key evil-normal-state-map (kbd "Q") 'evil-quit)
  (define-key evil-normal-state-map (kbd "s-i") 'evil-quit)
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

;; (use-package rg
;;   :ensure t)

;(use-package evil-collection
;  :after evil
;  :ensure t
;  :config
;  (evil-collection-init))

(ivy-mode)

(add-hook 'evil-mode-hook
	  (lambda ()
	    (evil-escape-mode)))

(add-hook 'cider-repl-mode-hook
	  (lambda ()
	    (company-mode)))

(add-hook 'cider-mode-hook
	  (lambda ()
	    (with-eval-after-load 'evil-maps
	      (define-key evil-normal-state-map (kbd "K") 'cider-doc)
	      (define-key evil-normal-state-map (kbd "gd") 'cider-find-var)
	      (define-key evil-normal-state-map (kbd "gd") 'cider-find-var)
	      (define-key evil-normal-state-map (kbd "gl") 'integrant-reset)
	      (define-key evil-normal-state-map (kbd "gh") 'integrant-halt)
	      (define-key evil-normal-state-map (kbd "<s-return>") 'cider-pprint-eval-last-sexp)
	      (define-key evil-insert-state-map (kbd "<s-return>") 'cider-pprint-eval-last-sexp))
	    (evil-escape-mode)
	    (company-mode)))

(add-hook 'clojure-mode-hook
	  (lambda ()
	    (lispy-mode)
	    ;; Half the time 'e' breaks in regular CLJ mode anyway, so just use our replacement.
	    (modify-syntax-entry ?- "w" clojure-mode-syntax-table)
	    (modify-syntax-entry ?_ "w" clojure-mode-syntax-table)
	    (modify-syntax-entry ?> "w" clojure-mode-syntax-table)
	    (lispy-clojurescript-mode)
	    (company-mode)))

(add-hook 'clojurescript-mode-hook
	  (lambda ()
	    (lispy-mode)
	    (lispy-clojurescript-mode)
	    (company-mode)))

(defun lispy-fennel--eval (arg)
  (interactive "P")
  (let* ((b (lispy--bounds-dwim))
	(start (car b))
	(end (cdr b)))
    (lisp-eval-region start end)))

(defun lispy-fennel--eval-buffer (arg)
  (interactive "P")
  (lisp-eval-region (point-min) (point-max)))

(define-minor-mode lispy-fennel-mode
  "Minor mode that makes lispy work with fennel-mode"
  :init-value nil
  :keymap (make-sparse-keymap)
  (lambda ()
    (define-key evil-normal-state-local-map (kbd "g R") 'lispy-fennel--eval-buffer)))

(defun lispy-clojurescript--eval (arg)
  (interactive "P")
  (let* ((b (lispy--bounds-dwim))
	 (start (car b))
	 (end (cdr b)))
    (cider-eval-region start end)))

(lispy-define-key lispy-fennel-mode-map (kbd "e") 'lispy-fennel--eval)

(define-minor-mode lispy-clojurescript-mode
  "Minor mode that makes lispy work with clojurescript-mode"
  :init-value nil
  :keymap (make-sparse-keymap)
  (lambda ()
    (define-key evil-normal-state-local-map (kbd "g R") 'lispy-fennel--eval-buffer)
    ))

(lispy-define-key lispy-clojurescript-mode-map (kbd "e") 'lispy-clojurescript--eval)


;; Super hacky thing that just makes lispy work when we connect to a
;; running shadow-cljs REPL. The problem we are avoiding here is that
;; when we press 'e' lispy tries to load its cljs library, but
;; shadow-cljs baulks at that because it's not on the classpath.
(defun hack-fix-cljs (arg)
  (interactive "P")
  (lispy-define-key lispy-mode-map (kbd "e") 'lispy-cljs--eval))

(add-hook 'fennel-mode-hook
	  (lambda ()
	    (setq fennel-mode-switch-to-repl-after-reload nil)
	    (evil-mode)
	    (lispy-mode)
	    (lispy-fennel-mode)
	    (company-mode)))

;; (add-hook 'fennel-mode-hook
;; 	  'lispy-fennel-mode)

;; (defun fennel-mode-setup ()
;;   (when (and (stringp buffer-file-name)
;; 	     (string-match "\\.fnl$" buffer-file-name))
;;     (lispy-define-key lispy-mode-map (kbd "e") 'eval--fennel)))

;; (add-hook 'find-file-hook #'fennel-mode-setup)

;; (mapcar 'car minor-mode-map-alist)
;; (counsel-mode
;;  undo-tree-visualizer-selection-mode
;;  undo-tree-mode
;;  magit-blame-read-only-mode
;;  magit-blame-mode
;;  magit-blob-mode
;;  smerge-mode
;;  diff-minor-mode
;;  git-commit-mode
;;  transient-resume-mode
;;  mml-mode
;;  with-editor-mode
;;  which-key-mode
;;  company-mode
;;  lispyville-mode
;;  reveal-mode
;;  flyspell-mode
;;  ispell-minor-mode
;;  rectangle-mark-mode
;;  lispy-other-mode
;;  lispy-goto-mode
;;  lispy-mode
;;  ivy-mode
;;  outline-minor-mode
;;  edebug-mode
;;  cider--debug-mode
;;  cider-mode
;;  compilation-minor-mode
;;  compilation-shell-minor-mode
;;  cider-popup-buffer-mode
;;  visual-line-mode
;;  isearch-mode)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (evil-mode)
	    (lispy-mode)
	    (company-mode)))

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")))


;; (unless (package-installed-p 'cider)
;;   (package-install 'cider))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-clojure-cli-aliases "dev")
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(package-selected-packages
   '(org-plus-contrib lispy rg projectile git-gutter which-key whichkey evil-escape undo-tree rainbow-delimiters gruvbox-theme magit company evil-collection evil cider use-package))
 '(safe-local-variable-values
   '((cider-shadow-cljs-default-options . "app")
     (cider-clojure-cli-aliases "dev"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
