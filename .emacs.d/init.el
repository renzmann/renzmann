;;; init.el --- my emacs init
;;
;; Author : Robert Enzmann
;;
;;; Commentary:
;; I put this here to make the linter stop whining.
;;
;;; Code

;; External Packages
;; ============================================================================
;; Enable MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
              (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "Your version of Emacs does not support SSL connections."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives '(cons "melpa-stable" (concat proto "://stable.melpa.org/packages/"))))

(setq package-archive-priorities '(("gnu" . 30)("melpa-stable" . 20)("melpa" . 10)))

;; Install packages with (package-install-selected-packages)
;; Remove packages with (package-autoremove)
;; If you want to automate that, maybe add them to your 'emacs-startup-hook'?
;; Set 'package-enable-at-startup to 'nil' in early-init.el to disable everything on earth getting loaded on startup
;; Modify the 'package-load-list' variable to choose what's made available at startup
;; Improve startup times by setting the user option 'package-quickstart' to 't'; this requires manually running 'package-quickstart-refresh' when activations need to be changed

;; Here's an example for adding packages
;;
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;;
;; We could do that programmatically by setting `package-load-list' and looping over it
;; with 'package-install'
;; (setq package-load-list
;;       ('magit))

;; Project management
(unless (package-installed-p 'magit) (package-refresh-contents) (package-install 'magit))

;; Colors
(unless (package-installed-p 'nord-theme) (package-install 'nord-theme))

;; Editor Settings
;; ============================================================================
;; Color theme(s) considered:
;; wombat - links are hard to see (not a different color)
;; tsdh-dark - comments are hideous
;; deeper-blue - too high contrast
;; misterioso - ugly comments and links are only underlined (hard to see)
;; (load-theme 'tango-dark)
;; (load-theme nord)

;; Stop stupid bell
(setq ring-bell-function 'ignore)

;; Clock in statusline
(display-time)

;; Enable split-window dired copying
(setq dired-dwim-target t)

;; Interactive completion (bundled with emacs)
;; Very helpful resource on it: https://www.masteringemacs.org/article/introduction-to-ido-mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
  ;; `ffap` find file at point - we can try this later but "some people hate it"
  ;; (setq ido-use-filename-at-point 'guess)
(setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
  ;; modify 'completion-ignored-extensions with regexes to ignore some things (maybe useful for backup and object files?)
  ;; (setq ido-ignore-extensions t)
(ido-mode t)

;; Line and number modes
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(setq display-line-numbers-type 'relative)
(setq column-number-mode t)

;; Automatically create matching parens in lisp mode
(add-hook 'prog-mode-hook (electric-pair-mode t))
(add-hook 'prog-mode-hook (show-paren-mode t))

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Show markers for trailing whitespace and delete on save
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Don't wrap lines
(setq-default truncate-lines t)

;; Follow symlinks to the real file
(setq vc-follow-symlinks t)

;; Delete the region when we yank on top of it
(delete-selection-mode t)

;; Make cursor a vertical bar
;; (setq-default cursor-type 'bar)

;; Find recent files
(require 'recentf)
(recentf-mode t)

;; Enable mouse in terminal
(xterm-mouse-mode 1)

;; Scroll the compilation window as text appears
(setq compilation-scroll-output t)

;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

;; redirect custom so it doesn't edit this file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))


;; Keybindings
;; ============================================================================
;; Reserved for users: C-c <letter>
(global-set-key (kbd "C-c /") 'comment-line)
(global-set-key (kbd "C-c r") 'comment-or-uncomment-region)  ;; can we make the same keybinding as above work based on whether we've highlighted a region?

;; Reserved for users: f5 - f8
(global-set-key (kbd "<f5>") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
