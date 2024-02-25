(use-package python-mode
  :defer t)

(use-package python
  :hook (("\\.py\\" . python-mode)
	 (python-mode . lsp-mode)
	 (python-mode . company-mode)
	 (inferior-python-mode . company-mode)
	 )
  :config
    (set-repl-handler! 'python-mode #'+python/open-repl
	:persist t
	:send-region #'python-shell-send-region
	:send-buffer #'python-shell-send-buffer)

    (evil-define-key 'normal python-mode-map      (kbd "C-c C-l") 'python-shell-send-buffer)
    (evil-define-key 'normal python-mode-map      (kbd "C-c C-l") 'python-shell-send-buffer)
    (evil-define-key 'insert inferior-python-mode-map  (kbd "C-l") 'comint-clear-buffer)
    )

(use-package lsp-pyright
  :after lsp-mode
  :ensure t
  :custom
  ;; (lsp-pyright-auto-import-completions nil)
  (lsp-pyright-typechecking-mode "off")
  :config
  (fk/async-process
   "npm outdated -g | grep pyright | wc -l" nil
   (lambda (process output)
     (pcase output
       ("0\n" (message "Pyright is up to date."))
       ("1\n" (message "A pyright update is available."))))))
