(use-package company

  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.0)

  :hook ( (prog-mode . company-mode)
          (eshell-mode . company-mode)
	  (company-mode . (lambda () (company-tng-mode 1)))
	 )
  :init
  :config
  (setq company-minimum-prefix-length 2
        company-tooltip-limit 14
        company-tooltip-align-annotations t
        company-require-match 'never
        company-global-modes
        '(not erc-mode
              circe-mode
              message-mode
              help-mode
              gud-mode
              vterm-mode)
        company-frontends

        '(company-pseudo-tooltip-frontend
          company-echo-metadata-frontend)

        company-auto-commit 1

        company-dabbrev-other-buffers nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil)

  (setq company-backends '((company-capf company-dabbrev-code company-keywords company-yasnippet company-files)))
  )


(use-package company-box
  :after company-mode
  :hook (company-mode . company-box-mode))
