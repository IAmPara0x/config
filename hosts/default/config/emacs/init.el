(setq load-path (cons "~/.emacs.d/config" load-path))

(load "setup")
(load "theme")

(load "vertico-conf")
(load "consult-conf")
(load "company-conf")
(load "flycheck-conf")
(load "terminal")
(load "todo-conf")
(load "magit-conf")
(load "dired-conf")
(load "lsp-conf")
(load "projectile-conf")
;; (load "org-conf")
(load "eat-conf")

(defun load-lang (lang-name)
  (load (concat (prin1-to-string lang-name) "-conf")))

(defvar global/langs
  '(haskell
    nix
    python
    elisp
    purescript
    c
    clojure
    rust
    ;; go
    ;; racket
    ;; yaml
    ;; dhall
    ;; typescript
    ))

;; (mapc #'load-lang global/langs)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package evil
  :init
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-tree)

  :config

    (defun my/evil-shift-right ()
      (interactive)
      (evil-shift-right evil-visual-beginning evil-visual-end)
      (evil-normal-state)
      (evil-visual-restore))

    (defun my/evil-shift-left ()
      (interactive)
      (evil-shift-left evil-visual-beginning evil-visual-end)
      (evil-normal-state)
      (evil-visual-restore))

  ;; (setq evil-want-minibuffer t)

  (evil-mode 1)
  (undo-tree-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  
  (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)

  (evil-define-key 'visual global-map (kbd ">") 'my/evil-shift-right)
  (evil-define-key 'visual global-map (kbd "<") 'my/evil-shift-left)
  
  (evil-define-key 'normal 'global (kbd "<leader>ht") 'load-theme)
  (evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>ws") 'split-window-below)
  (evil-define-key 'normal 'global (kbd "<leader>wj") 'evil-window-down)
  (evil-define-key 'normal 'global (kbd "<leader>wk") 'evil-window-up)
  (evil-define-key 'normal 'global (kbd "<leader>wl") 'evil-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>wh") 'evil-window-left)
  (evil-define-key 'normal 'global (kbd "<leader>w+") 'enlarge-window)
  (evil-define-key 'normal 'global (kbd "<leader>w-") 'shrink-window)

  (evil-define-key 'normal 'global (kbd "<leader>s") 'evil-avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)

  (evil-define-key 'normal 'global (kbd "<leader>rr") 'query-replace)

  (evil-define-key 'normal 'global (kbd "<leader>ve") 'er/expand-region)
  (evil-define-key 'normal 'global (kbd "<leader>vr") 'er/contract-region)

  (define-key evil-normal-state-map "u" 'undo-tree-undo)
  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)

  ;; Compilation/loading in various modes
  
  (evil-define-key 'normal sh-mode-map          (kbd "C-c C-l") 'executable-interpret)

  ;; Finding docs
  
  (evil-define-key 'insert eshell-mode-map (kbd "C-l") 'eshell/clear))

(use-package evil-collection
  :after evil
  :init
  (evil-collection-init))

(use-package evil-escape
  :after evil
  :config (evil-escape-mode)
          (setq-default evil-escape-key-sequence "jk")
	  (setq-default evil-escape-delay 0.2))

(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode))

(use-package evil-snipe
  :after evil
  :config (evil-snipe-mode +1)
          (evil-snipe-override-mode +1))

(use-package avy
  :ensure t
  :after evil
  :config (setq avy-background t))


(use-package eimp
  :ensure t
  :config (add-hook 'image-mode-hook 'eimp-mode))

(use-package evil-cleverparens
  :ensure t
  :defer t
  :hook ((emacs-lisp-mode . evil-cleverparens-mode)
	 (clojure-mode . evil-cleverparens-mode)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-auto-select-error-buffer nil)
 '(cider-font-lock-dynamically '(macro function var core))
 '(cider-show-error-buffer 'only-in-repl)
 '(company-box-icons-alist 'company-box-icons-all-the-icons)
 '(custom-safe-themes
   '("4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d" "3de5c795291a145452aeb961b1151e63ef1cb9565e3cdbd10521582b5fd02e9a" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "75b2a02e1e0313742f548d43003fcdc45106553af7283fb5fad74359e07fe0e2" "7c7026a406042e060bce2b56c77d715c3a4e608c31579d336cb825b09e60e827" "3cdd0a96236a9db4e903c01cb45c0c111eb1492313a65790adb894f9f1a33b2d" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "badd1a5e20bd0c29f4fe863f3b480992c65ef1fa63951f59aa5d6b129a3f9c4c" "26149a1b5de476aa661bbb9c8f79540509c038fbba58c1c719466851c2968464" "74e2ed63173b47d6dc9a82a9a8a6a9048d89760df18bc7033c5f91ff4d083e37" "ec101eeff0195d92c3dc0c1c60edb1a84fa2adbbe8fdfea2a423aa95d1edc4d7" "180641b59315dcbf610ac82acbd80eb878ed969ba57a371345b4c58cff35d309" default))
 '(haskell-interactive-popup-errors nil)
 '(help-at-pt-display-when-idle '(flymake-overlay) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.9)
 '(lsp-haskell-server-path "haskell-language-server")
 '(lsp-ui-sideline-diagnostic-max-line-length 200)
 '(lsp-ui-sideline-diagnostic-max-lines 1)
 '(package-selected-packages
   '(lua-mode fish-mode gptel evil-cleverparens embark-consult embark treemacs-icons-dired fancy-dabbrev eimp yas-snippet org-pretty-tags org-mode nordic-night-theme python-mode typescript-mode expand-region dhall-mode no-littering flycheck-posframe nix-ts-mode nix-mode lsp-modevertico purescript-mode tree-sitter-langs unicode-fonts pdf-tools rust-mode yaml-mode catppuccin-theme cider inf-clojure clojure-mode projectile-ripgrep smartparens smart-parens git-gutter-fringe hl-todo hl-todo-mode vterm racket-mode avy eshell-git-prompt eshell-prompt-extras flymake-cursor flycheck flycheck-pos-tip kaolin-themes direnv evil-snipe agda2-mode all-the-icons-dired dired-single tree-sitter-mode company-box company haskell-mode evil-collection magit projectile evil-commentary evil-escape which-key undo-tree rainbow-delimiters helpful general evil doom-themes doom-modeline all-the-icons))
 '(warning-suppress-log-types
   '(((package reinitialization))
     ((package reinitialization))
     ((package reinitialization))
     (use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
