
(use-package multiple-cursors
  :ensure t
  :after evil evil-collection
  :config
    (evil-define-key 'normal 'global (kbd "C->") 'mc/mark-next-like-this)
    (evil-define-key 'normal 'global (kbd "C-<") 'mc/mark-previous-like-this)
    (evil-define-key 'normal 'global (kbd "C-c C-<") 'mc/mark-all-like-this)
    )
