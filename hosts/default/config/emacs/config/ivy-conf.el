
(defun ivy-mappings ())

(use-package ivy
  :ensure t
  :diminish
  :demand
  :after evil
  :hook ((ivy-mode . ivy-mappings))
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1)
  (evil-define-key 'normal 'global (kbd "<leader>fb") 'ivy-switch-buffer)
  )

(setq ivy-height 20
      ivy-wrap t
      ivy-fixed-height-minibuffer t
      ivy-read-action-function #'ivy-hydra-read-action
      ivy-read-action-format-function #'ivy-read-action-format-columns
      ;; don't show recent files in switch-buffer
      ivy-use-virtual-buffers nil
      ;; ...but if that ever changes, show their full path
      ivy-virtual-abbreviate 'full
      ;; don't quit minibuffer on delete-error
      ivy-on-del-error-function #'ignore
      ;; enable ability to select prompt (alternative to `ivy-immediate-done')
      ivy-use-selectable-prompt t)

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode 1)
  (setq search-default-mode #'char-fold-to-regexp))
