(use-package counsel
   :ensure t
   :after evil
   :diminish
   :config
   (counsel-mode 1)
   (evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file)
   (evil-define-key 'normal 'global (kbd "<leader>rf") 'counsel-recentf)
   (evil-define-key 'normal 'global (kbd "<leader>fg") 'counsel-git-grep)
   (evil-define-key 'normal 'global (kbd "M-p") 'counsel-M-x))
