;; C-c user keys
;; a
(global-set-key (kbd "C-c a") 'change-outer)
;; c
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
;; e
(global-set-key (kbd "C-c e n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c e p") 'flymake-goto-prev-error)
;; f
(global-set-key (kbd "C-c f r") 'recentf-open-files)
(global-set-key (kbd "C-c f f") 'find-file-at-point)
;; i
(global-set-key (kbd "C-c i") 'change-inner)
;; p
(global-set-key (kbd "C-c p a") 'pyvenv-activate)
(global-set-key (kbd "C-c p d") 'pyvenv-deactivate)
(global-set-key (kbd "C-c p f") 'elpy-black-fix-code)
;; s
(global-set-key (kbd "C-c s i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c s k") (lambda () (interactive) (find-file "~/.emacs.d/keybindings.el")))
;; t
(global-set-key (kbd "C-c t w") 'delete-trailing-whitespace)
;; v
(global-set-key (kbd "C-c v") 'evil-mode)

;; Super user keys
;; overrides isearch-forward, which is already on C-s
(global-set-key (kbd "s-f") 'helm-projectile-find-file)
;; overrides isearch-repeat-forward
(global-set-key (kbd "s-g") 'helm-projectile-rg)
;; no default on s-i
(global-set-key (kbd "s-i") 'er/contract-region)
;; overrides ns-open-file-using-panel
(global-set-key (kbd "s-o") 'er/expand-region)
;; overrides ns-print-buffer
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
