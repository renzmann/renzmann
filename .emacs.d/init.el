;;; init.el --- my emacs init
;;
;; Author : Robert Enzmann
;;
;;; Commentary:
;; I put this here to make the linter stop whining.
;;
;;; Code

;; redirect custom so it doesn't edit this file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; =======================================================================
;; Package management
;; =======================================================================
;; Enable MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "Your version of Emacs does not support SSL connections."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

;; Install use-package if it hasn't been already
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

;; =======================================================================
;; Basic preferences
;; =======================================================================
;; Color theme
(use-package gruvbox-theme :ensure t)
(load-theme 'gruvbox-dark-soft)

;; Bigger font
;; (set-frame-font "JetBrains Mono 13" nil t)

;; Stop stupid bell
(setq ring-bell-function 'ignore)

;; clock in statusline
(display-time)

;; Enable split-window dired copying
(setq dired-dwim-target t)

;; If in a GUI, set the window a bit bigger and more centered
(if (window-system) (set-frame-size (selected-frame) 124 50))
(if (window-system) (set-frame-position (selected-frame) 300 30))

;; Line and number modes
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
(setq display-line-numbers-type 'relative)
(setq column-number-mode t)

;; Automatically create matching parens in lisp mode
(add-hook 'lisp-mode (electric-pair-mode t))
(add-hook 'prog-mode-hook (show-paren-mode t))

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Version control (magit)
(use-package magit :ensure magit)

;; evil - vim keybindings
(use-package evil :ensure evil)

;; show markers for trailing whitespace and delete on save
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; don't wrap lines
(setq-default truncate-lines t)

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Delete the region when we yank on top of it
(delete-selection-mode t)

;; Make cursor a vertical bar
(setq-default cursor-type 'bar)

(defun funced (name)
  "Edit a bash function."
  (interactive "sFunction to edit: ")
  (find-file (format "~/.bash_functions/%s.sh" name)))

;; Find recent files
(require 'recentf)
(recentf-mode t)

;; Add semantic expansion and vim-like "ci" and "ca"
(use-package expand-region :ensure expand-region)
(use-package change-inner :ensure change-inner)

;; Enable mouse in terminal
(xterm-mouse-mode 1)

;; Scroll the compilation window as text appears
(setq compilation-scroll-output t)

;; =======================================================================
;; Extra file modes
;; =======================================================================
(use-package vimrc-mode :ensure vimrc-mode)
(use-package yaml-mode :ensure yaml-mode)
(use-package markdown-mode :ensure markdown-mode)
;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode :ensure dockerfile-mode)
(use-package terraform-mode :ensure terraform-mode)
(use-package typescript-mode :ensure typescript-mode)
(use-package julia-mode :ensure julia-mode)

;; =======================================================================
;; Projectile - Project Management and searching
;; =======================================================================
;; Ido (Interactively DO) adds some completion niceties and is distributed
;; with emacs. https://www.gnu.org/software/emacs/manual/html_mono/ido.html#Overview
;; Leaving this commented in case we want to come back to it.
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (use-package smex :ensure smex)

;; Ivy for minibuffer completion, recommended by projectile over IDO
;; Ivy consists of three parts:
;;  1. Ivy, a generic completion mechanism for Emacs.
;;  2. Counsel, a collection of Ivy-enhanced versions of common Emacs commands.
;;  3. Swiper, an Ivy-enhanced alternative to Isearch.
(use-package ivy :ensure ivy)
(use-package counsel :ensure counsel)
(use-package swiper :ensure swiper)
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(use-package projectile :ensure t)
(use-package rg :ensure rg)
(use-package counsel-projectile :ensure counsel-projectile)
(projectile-mode t)
(counsel-projectile-mode t)
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'native)

;; =======================================================================
;; Python Configuration
;; =======================================================================
(use-package python :ensure t)
(use-package pyvenv :ensure pyvenv)

;; f-string highlighting
;; https://emacs.stackexchange.com/a/61244
(defconst brace-regexp  "[^{]{[^{}]*}")
(defconst python-f-string-regexp  "f\\('.*?[^\\]'\\|\".*?[^\\]\"\\)")

;; (defun python-f-string-font-lock-find (limit)
;;   (while (re-search-forward python-f-string-regexp limit t)
;;     (put-text-property (match-beginning 0) (match-end 0)
;;                        'face 'font-lock-string-face)
;;     (let ((start (match-beginning 0)))
;;       (while (re-search-backward brace-regexp start t)
;;         (put-text-property (1+ (match-beginning 0)) (match-end 0)
;;                            'face 'font-lock-type-face))))
;;   nil)

;; (with-eval-after-load 'python
;;   (font-lock-add-keywords
;;    'python-mode
;;    '((python-f-string-font-lock-find))
;;    'append))

;; black formatting for buffers
(use-package blacken :ensure blacken)

;; =======================================================================
;; Completion
;; =======================================================================
;; Elpy installs `company`, but we ensure it here if we're not using elpy
;; https://company-mode.github.io/
(use-package company :ensure company)
(add-hook 'after-init-hook 'global-company-mode)

;; Company is not a fuzzy-matcher:
;; https://github.com/company-mode/company-mode/issues/296#issuecomment-73000089
(add-to-list 'completion-styles 'initials t)


;; =======================================================================
;; Language server
;; =======================================================================
;; "It's elpy or lsp-mode, no reason to use both"
(use-package lsp-mode :ensure lsp-mode)
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))

;; =======================================================================
;; Extras
;; =======================================================================
(load-file "~/.emacs.d/keybindings.el")
(exec-path-from-shell-initialize)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(provide 'init)
