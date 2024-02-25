(use-package typescript-mode
  :ensure t
  :hook ( (typescript-mode . lsp)
	  (typescript-mode . company-mode)
	 )
  )
