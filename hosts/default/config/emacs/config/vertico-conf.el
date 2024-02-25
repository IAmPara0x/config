(require 'cl-lib)

(use-package vertico
  :after evil evil-collection
  :ensure t
  :init (vertico-mode)
  :bind
  (:map vertico-map
   ("C-j" . vertico-next)
   ("C-k" . vertico-previous)
   ("C-f" . vertico-exit)
   )
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 20)
  (setq vertico-cycle t))

(use-package savehist
  :after vertico
  :init
  (savehist-mode))

(use-package orderless
  :after vertico
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :after vertico
  :ensure t

  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :custom (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(defun embark-which-key-indicator ()
  "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))


(defun embark-hide-which-key-indicator (fn &rest args)
  "Hide the which-key indicator immediately when using the completing-read prompter."
  (which-key--hide-popup-ignore-command)
  (let ((embark-indicators
         (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

(use-package embark
  :after vertico
  :ensure t
  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("M-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  (defun run-cabal-command (region)

    (let* ((tokens (cl-remove-if #'string-empty-p (split-string region " ")))
	   (command-type (car tokens))
	   (command-name (cadr tokens)))

      (defun compile-or-projectile-cmd (type arg)
	(if (member projectile-mode minor-mode-list)
	    (cond ((eq type 'test) (projectile-test-project arg))
		  ((eq type 'lib) (projectile-compile-project arg))
		  ((eq type 'exe) (projectile-run-project arg))
		  (t (projectile-compile-project arg)))
	  (compile arg)))

      (cond ((string= command-type "test-suite")
	     (compile-or-projectile-cmd 'test (format "cabal test %s" command-name)))
	    ((string= command-type "executable")
	     (compile-or-projectile-cmd 'exe (format "cabal install %s" command-name)))
	    ((string= command-type "library")
	     (compile-or-projectile-cmd 'lib "cabal build"))
	    (t (projectile-compile-project nil (format "cabal %s %s" command-type command-name))))))

  (defun run-makefile-command (region)
    (let* ((tokens (cl-remove-if #'string-empty-p (split-string region ":")))
	   (command-name (car tokens)))
      (compile (format "make %s" command-name))))

  (defun compile-command (region)
    (cond ((eq major-mode 'haskell-cabal-mode)
	   (run-cabal-command region))
	  ((eq major-mode 'makefile-gmake-mode)
	   (run-makefile-command region)
	   )
	  (t (compile region))))

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

  (setq embark-indicators
	'(embark-which-key-indicator
	  embark-highlight-indicator
	  embark-isearch-highlight-indicator))

  (advice-add #'embark-completing-read-prompter
              :around #'embark-hide-which-key-indicator)

  (define-key embark-region-map (kbd "c") 'compile-command)
  )

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :after (embark consult)
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))



