(use-package rust-mode
  :init
  :after evil
  :hook ( (rust-mode . lsp-mode)
	  (rust-mode . company-mode)
	 )
  :config
  (setq indent-tabs-mode nil)
  (evil-define-key 'normal rust-mode-map (kbd "C-c C-l") 'rust-compile)
  (evil-define-key 'normal rust-mode-map (kbd "C-c C-r") 'rust-run)
  (prettify-symbols-mode))


;; (use-package rust-mode
;;   :init
;;   :defer t
;;   :hook ( ("\\.rs\\" . rust-mode)
;; 	  (rust-mode . company-mode)
;; 	  (rust-mode . lsp-mode)
;; 	  )
;;   :config
;;   (evil-define-key 'normal rust-mode-map (kbd "C-c C-l") 'rust-compile)
;;   (evil-define-key 'normal rust-mode-map (kbd "C-c C-r") 'rust-run)
;;   (setq indent-tabs-mode nil)
;;   (prettify-symbols-mode)
;;   )
