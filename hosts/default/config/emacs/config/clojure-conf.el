(use-package clojure-mode
  :defer t
  :hook (("\\.clj\\" . clojure-mode)
	 (clojure-mode . lsp-mode)
	 )
  :config
  (setq clojure-indent-style always-indent)
  )

(use-package cider
  :after clojure-mode
  :config
  (setq cider-allow-jack-in-without-project t)
  (setq cider-font-lock-dynamically '(macro core function var))
  (evil-define-key 'insert cider-repl-mode-map     (kbd "C-l") 'cider-repl-clear-buffer)
  (evil-define-key 'normal clojure-mode-map     (kbd "C-c C-l") 'cider-load-buffer))
