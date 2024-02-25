(use-package magit
  :ensure t
  :after evil
  :config (evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status))
