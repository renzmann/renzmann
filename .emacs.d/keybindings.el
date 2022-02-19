;; C-c user keys
;; c
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
;; e : errors
(global-set-key (kbd "C-c e n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c e p") 'flymake-goto-prev-error)
;; f : files
(global-set-key (kbd "C-c f r") 'recentf-open-files)
(global-set-key (kbd "C-c f f") 'find-file-at-point)
(global-set-key (kbd "C-c f s") 'helm-projectile-find-file)
(global-set-key (kbd "C-c f g") 'helm-projectile-rg)
(global-set-key (kbd "C-c f a") (lambda () (interactive) (find-file "~/.aws/credentials")))
;; i
(global-set-key (kbd "C-c i") 'change-inner)
;; o
(global-set-key (kbd "C-c o") 'change-outer)
;; p : python
(global-set-key (kbd "C-c p a") 'pyvenv-activate)
(global-set-key (kbd "C-c p d") 'pyvenv-deactivate)
(global-set-key (kbd "C-c p f") 'elpy-black-fix-code)
;; s : settings
(global-set-key (kbd "C-c s i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c s k") (lambda () (interactive) (find-file "~/.emacs.d/keybindings.el")))
;; t
(global-set-key (kbd "C-c t w") 'delete-trailing-whitespace)
;; v
(global-set-key (kbd "C-c v") 'evil-mode)

;; Motion keys
(global-set-key (kbd "C-<left>") 'er/contract-region)
(global-set-key (kbd "C-<right>") 'er/expand-region)

;; Default overrides
;; projectile prefix : C-t overrides transpose-characters
(global-set-key (kbd "C-t") 'projectile-command-map)
