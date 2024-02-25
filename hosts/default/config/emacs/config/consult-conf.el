(use-package consult
  :ensure t
  :after evil
  :init (recentf-mode)
  :config
  (evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>rf") 'consult-recent-file))
