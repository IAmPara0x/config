(use-package eat
  :ensure t
  :config
  (add-hook 'eshell-load-hook #'eat-eshell-mode))

(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))
