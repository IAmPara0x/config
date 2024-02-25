(use-package haskell-mode
  :init
  :after evil
  :hook (
	  (haskell-mode . lsp)
	  (haskell-mode . lsp-deferred)
	  (haskell-mode . company-mode)
	  (haskell-mode . lsp-signature-mode)
	  (haskell-literate-mode . lsp)
	  (haskell-mode . (lambda () (evil-define-key 'normal haskell-mode-map (kbd "C-c C-x") 'kill-compilation))))
  :config
  (setq haskell-process-suggest-remove-import-lines t  ; warnings for redundant imports etc
		haskell-process-auto-import-loaded-modules t)
  (evil-define-key 'insert haskell-interactive-mode-map (kbd "C-l") 'haskell-interactive-mode-clear)
  )

(use-package lsp-haskell
  :after lsp-mode haskell-mode)
