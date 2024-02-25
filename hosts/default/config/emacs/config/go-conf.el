
;; (use-package go-mode
;;  :ensure t
;;  :init
;;  :after evil lsp-mode
;;  :hook ( (go-mode . lsp)
;; 	 (go-mode . lsp-deferred)
;; 	 (go-mode . (lambda () (company-mode) (setq-local company-backends '((company-capf company-dabbrev-code company-keywords company-yasnippet)))))))

(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(add-hook 'go-mode-hook 'lsp)
(add-hook 'go-mode-hook 'company-mode)
