(use-package flycheck
  :defer t
  :ensure t
  :init (flycheck-mode)
  :hook (flycheck-mode . flycheck-pos-tip-mode)
  )

(use-package flycheck-pos-tip
  :ensure t)
