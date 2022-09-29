;;; keybindings.el -*- lexical-binding: t; -*-

(defun renz/org-kill-src-block ()
  "Kill the src block around point, if applicable."
  (interactive)
  (org-babel-remove-result)
  (org-mark-element)
  (kill-region nil nil t))

;; ----------------------------------------
;; C-c <letter> bindings
;; ----------------------------------------
;; Reserved for users:
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Key-Bindings.html
(global-set-key (kbd "C-c a") #'org-agenda)
;; (global-set-key (kbd "C-c b") #')
(global-set-key (kbd "C-c c") #'org-capture)
;; (global-set-key (kbd "C-c d") #')
;; (global-set-key (kbd "C-c e") #')
;; (global-set-key (kbd "C-c f") #')
;; (global-set-key (kbd "C-c g") #')
;; (global-set-key (kbd "C-c h") #')
;; (global-set-key (kbd "C-c i") #')
(global-set-key (kbd "C-c j") #'imenu)  ; matches major modes that use C-c C-j
;; (global-set-key (kbd "C-c k") #')
(global-set-key (kbd "C-c l") #'lsp)
;; (global-set-key (kbd "C-c m") #')
;; (global-set-key (kbd "C-c n") #')
(global-set-key (kbd "C-c o") #'change-outer)
;; (global-set-key (kbd "C-c p") #')
;; (global-set-key (kbd "C-c q") #')
;; (global-set-key (kbd "C-c r") #')
;; (global-set-key (kbd "C-c s") #')
(global-set-key (kbd "C-c t") #'org-babel-detangle)
;; (global-set-key (kbd "C-c u") #')
;; (global-set-key (kbd "C-c v") #')
(global-set-key (kbd "C-c w") #'renz/org-kill-src-block)
;; (global-set-key (kbd "C-c x") #')
;; (global-set-key (kbd "C-c y") #')
;; (global-set-key (kbd "C-c z") #')
;
;; ----------------------------------------
;; F5 - F9
;; ----------------------------------------
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "M-<f5>") 'recompile)
;; (global-set-key (kbd "<f6>") ')
;; (global-set-key (kbd "M-<f6>") ')
;; (global-set-key (kbd "<f7>") ')
;; (global-set-key (kbd "M-<f7>") ')
;; (global-set-key (kbd "<f8>") ')
;; (global-set-key (kbd "M-<f8>") ')
(global-set-key (kbd "<f9>") 'vterm)
;; (global-set-key (kbd "M-<f9>") ')
;; ----------------------------------------
