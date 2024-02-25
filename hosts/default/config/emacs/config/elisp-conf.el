(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (evil-define-key 'normal emacs-lisp-mode-map  (kbd "C-c C-l") 'eval-buffer)))
