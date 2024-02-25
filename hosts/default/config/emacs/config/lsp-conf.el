(use-package lsp-mode
  :init
  :after evil
  :config

  (lsp-enable-which-key-integration t)
  (setq lsp-completion-provider :none)
  (setq lsp-prefer-flymake nil)
  (setq lsp-log-io nil)

  ;; Mappings

  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>la") 'lsp-execute-code-action)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>lr") 'lsp-find-references)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>ld") 'lsp-find-definition)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>lR") 'lsp-rename)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>lD") 'flymake-show-buffer-diagnostics)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>le") 'flycheck-error-list-explain-error)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>ln") 'flycheck-next-error)
  (evil-define-key 'normal 'lsp-mode-map (kbd "<leader>lp") 'flycheck-previous-error)

  (define-advice json-parse-buffer (:around (old-fn &rest args) lsp-booster-parse-bytecode)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
	 (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))

  (define-advice lsp-resolve-final-command (:around (old-fn cmd &optional test?) add-lsp-server-booster)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
	orig-result)))
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))
