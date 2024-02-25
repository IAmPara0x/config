

(defun window-map ()
  (evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>ws") 'split-window-below)
  (evil-define-key 'normal 'global (kbd "<leader>wj") 'evil-window-down)
  (evil-define-key 'normal 'global (kbd "<leader>wk") 'evil-window-up)
  (evil-define-key 'normal 'global (kbd "<leader>wl") 'evil-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>wh") 'evil-window-left)
  (evil-define-key 'normal 'global (kbd "<leader>w+") 'enlarge-window)
  (evil-define-key 'normal 'global (kbd "<leader>w-") 'shrink-window)
  )



(use-package pdf-tools
  :ensure t
  :after evil
  :hook (pdf-view-mode . window-map)
  :config
  (pdf-loader-install)
  )
