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
  )
(package-initialize)

;; Install use-package if it hasn't been already
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package))
)

(require 'use-package)

;; =======================================================================
;; Basic preferences
;; =======================================================================

;; Bigger font
(set-frame-font "Menlo 14" nil t)

;; Stop stupid bell
(setq ring-bell-function 'ignore)

;; clock in statusline
(display-time)

;; Enable split-window dired copying
(setq dired-dwim-target t)

;; If in a GUI, set the window a bit bigger and more centered
(if (window-system) (set-frame-size (selected-frame) 124 50))
(if (window-system) (set-frame-position (selected-frame) 400 60))

;; Line and number modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Automatically create matching parens in lisp mode
(add-hook 'lisp-mode (electric-pair-mode t))

;; Ido (Interactively DO) adds some completion niceties and is distributed
;; with emacs. https://www.gnu.org/software/emacs/manual/html_mono/ido.html#Overview
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Provides clipboarding to the outside OS
;; Copy:  C-<Ins>
;; Paste: S-<Ins>
;; Cut:   S-<Del>
(use-package simpleclip :ensure simpleclip)

;; Version control (magit)
(use-package magit :ensure magit)
(global-set-key (kbd "C-; g") 'magit)

;; evil - vim keybindings
;; resist the temptation... but in case we want it it's here.
;; (use-package evil :ensure evil)
;; (global-set-key (kbd "C-;") 'evil-mode)

;; Color theme
(load-theme 'wombat)

;; show markers for trailing whitespace and delete on save
(setq-default show-trailing-whitespace t)
(add-hook 'beore-save-hook 'delete-trailing-whitespace)

;; delete trailing whitespace
(global-set-key (kbd "C-; t w") 'delete-trailing-whitespace)

;; don't wrap lines
(setq-default truncate-lines t)

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Provides clipboarding to the outside OS
;; Copy:  C-<Ins>
;; Paste: S-<Ins>
;; Cut:   S-<Del>
(use-package simpleclip :ensure simpleclip)

;; evil - vim keybindings
;; (use-package evil :ensure evil)
;; (global-set-key (kbd "C-;") 'evil-mode)

(defun funced (name)
  "Edit a bash function."
  (interactive "sFunction to edit: ")
  (find-file (format "~/.bash_functions/%s.sh" name)))

;; =======================================================================
;; Extra file modes
;; =======================================================================
(use-package vimrc-mode :ensure vimrc-mode)
(use-package yaml-mode :ensure yaml-mode)
(use-package markdown-mode :ensure markdown-mode)

;; =======================================================================
;; Projectile - Project Management
;; =======================================================================
;; Let's learn dired first, then come to this.
;;
;; (use-package helm :ensure t)
;; (use-package projectile :ensure t)
;; (projectile-mode)
;; (setq projectile-completion-system 'helm)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (global-set-key (kbd "C-S-n") 'projectile-find-file)
;; (setq projectile-enable-caching t)
;; (setq projectile-indexing-method 'native)

;; =======================================================================
;; Language config sources
;; =======================================================================
;; Not sure yet what elpy adds on top of built-in. Might add this back
;; once I know.

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i")

;; (use-package elpy
;;   :ensure t
;;   :config
;;   (elpy-enable)
;;   (add-to-list 'python-shell-completion-native-disabled-interpreters "ipython")
;;   (setq python-shell-interpreter "ipython"
;; 	python-shell-interpreter-args "-i --simple-prompt")
;;   (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1))))

;; just install this on demand - when opening a julia file
;; (use-package julia-mode :ensure julia-mode)
;; (use-package julia-repl :ensure julia-repl)
;; (use-package flycheck-julia :ensure flycheck-julia)
;; (add-hook 'julia-mode-hook 'julia-repl-mode)
;; (use-package eglot-jl :ensure eglot-jl)

(provide 'init)
