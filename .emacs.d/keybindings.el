;; ===================================================================
;; C-c user keys
;; ===================================================================
;; c : comments
(global-set-key (kbd "C-c c l") 'comment-line)
(global-set-key (kbd "C-c c r") 'comment-or-uncomment-region)
;; e : errors
(global-set-key (kbd "C-c e n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c e p") 'flymake-goto-prev-error)
;; f : files
(global-set-key (kbd "C-c f r") 'recentf-open-files)
(global-set-key (kbd "C-c f f") 'find-file-at-point)
(global-set-key (kbd "C-c f a") (lambda () (interactive) (find-file "~/.aws/credentials")))
(global-set-key (kbd "C-c f i") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c f k") (lambda () (interactive) (find-file "~/.emacs.d/keybindings.el")))
;; g
(global-set-key (kbd "C-c g") 'counsel-git)
;; i
(global-set-key (kbd "C-c i") 'change-inner)
;; j
(global-set-key (kbd "C-c j") 'counsel-git-grep)
;; k
(global-set-key (kbd "C-c k") 'counsel-rg)
;; l
(global-set-key (kbd "C-c l") 'counsel-locate)
;; o
(global-set-key (kbd "C-c o") 'change-outer)
;; p : python
(global-set-key (kbd "C-c p a") 'pyvenv-activate)
(global-set-key (kbd "C-c p d") 'pyvenv-deactivate)
(global-set-key (kbd "C-c p f") 'elpy-black-fix-code)
;; t
(global-set-key (kbd "C-c t w") 'delete-trailing-whitespace)
;; v
(global-set-key (kbd "C-c v") 'evil-mode)

;; ===================================================================
;; Motion keys
;; ===================================================================
(global-set-key (kbd "C-<left>") 'er/contract-region)
(global-set-key (kbd "C-<right>") 'er/expand-region)

;; ===================================================================
;; Default overrides
;; ===================================================================
;; Ivy versions of common commands
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;; projectile prefix : C-t overrides transpose-characters
(global-set-key (kbd "C-t") 'projectile-command-map)

;; smex enhanced M-x, commented in case we want it back
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)  ;; old M-x

;; ===================================================================
;; Fn keys
;; ===================================================================
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)

(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

(global-set-key (kbd "<f6>") 'ivy-resume)

;; ===================================================================
;; Ctrl + Shift commands (poor man's super)
;; ===================================================================
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; do this for spotify! https://github.com/Lautaro-Garcia/counsel-spotify
