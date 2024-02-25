(use-package purescript-mode
  :ensure t
  :defer t
  :after evil evil-collection
  :hook (
	  ("\\.purs\\" . purescript-mode)
	  (purescript-mode . lsp-mode)
	  (purescript-mode . company-mode)
	  (purescript-mode . purescript-indentation-mode)
	  (purescript-mode .
			   (lambda ()
			     (evil-define-key 'normal purescript-mode-map (kbd "C-c C-l") 'compile)
			     (evil-define-key 'normal purescript-mode-map (kbd "C-c C-x") 'kill-compilation))
			   )
	  )
  )

