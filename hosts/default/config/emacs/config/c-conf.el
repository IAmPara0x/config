(defun lang-lsp ()
  (lsp)
  (company-mode))

(defun c-mode-mappings ()
  (evil-define-key 'normal c-mode-map           (kbd "<leader>fd") 'man)
  (evil-define-key 'normal c-mode-map           (kbd "C-c C-l") 'compile))

(add-hook 'c-mode-hook 'lsp-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'c-mode-mappings)
