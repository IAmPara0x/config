(use-package projectile
  :init
  (when (file-directory-p "~/Desktop/")
    (setq projectile-project-search-path '("~/Desktop")))
  (setq projectile-switch-project-action #'projectile-dired)
  :after evil evil-collection
  :diminish projectile-mode
  :config
  (projectile-mode)
  (evil-define-key 'normal projectile-mode-map  (kbd "<leader>fr") 'projectile-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>p") 'projectile-command-map))

(use-package projectile-ripgrep)
