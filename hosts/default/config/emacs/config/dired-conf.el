(use-package dired
  :ensure nil
  :after evil evil-collection undo-tree
  :hook ((dired-mode . undo-tree-mode))
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>dj") 'dired-jump)
  (setq dired-dwim-target t))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
