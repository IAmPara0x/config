(use-package racket-mode
  :ensure t
  :defer t
  :after evil
  :hook ( (racket-mode . company-mode)
	  (racket-mode . (lambda () (company-tng-mode)))
	  (racket-mode . (lambda () (structural-editting racket-mode-map)))
	  )
  :config
  
  (evil-define-key 'insert racket-repl-mode-map      (kbd "C-l") 'racket-repl-clear-leaving-last-prompt)
  (evil-define-key 'normal racket-mode-map      (kbd "C-M-l") 'racket-insert-lambda)
  (evil-define-key 'insert racket-mode-map      (kbd "C-M-l") 'racket-insert-lambda)
  (evil-define-key 'insert racket-mode-map      (kbd "C-x C-e") 'racket-eval-last-sexp)
  (evil-define-key 'normal racket-mode-map      (kbd "C-c C-l") 'racket-run)
  (evil-define-key 'normal 'racket-xp-mode (kbd "<leader>ln") 'racket-xp-next-error)
  (evil-define-key 'normal 'racket-xp-mode (kbd "<leader>lp") 'racket-xp-previous-error)
  (evil-define-key 'normal 'racket-xp-mode (kbd "<leader>lR") 'racket-xp-rename))
