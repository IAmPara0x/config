(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq inhibit-startup-message t)

(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)
(setq use-dialog-box nil)

(when (bound-and-true-p tooltip-mode)
  (tooltip-mode -1))

(setq gc-cons-threshold 100000000)
(setq process-adaptive-read-buffering nil)
(setq read-process-output-max (* 4 1024 1024))

(setq x-gtk-use-system-tooltips nil)
(set-fringe-mode 10)
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font Mono" :height 100 :weight 'Bold)


;; Load use-package

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/use-package")
  (require 'use-package))

(setq use-package-always-ensure t)

(global-set-key (kbd "C-c C-c") 'keyboard-escape-quit)

(use-package ansi-color
  :ensure t
  :config (progn 
            (defun my/ansi-colorize-buffer ()
              (let ((buffer-read-only nil))
                (ansi-color-apply-on-region (point-min) (point-max))))
            (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)))

(visual-line-mode)

(use-package undo-tree
  :init
  :config
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))

(use-package general)

(use-package no-littering
  :ensure t
  :init)

(use-package smooth-scrolling)
(smooth-scrolling-mode 1)

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package all-the-icons
  :disable
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :disable
  :if (display-graphic-p)
  :after all-the-icons
  :hook (marginalia-mode . all-the-icons-completion-mode))

(use-package expand-region
  :ensure t
  :init)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq inhibit-startup-message t)

(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)
(setq use-dialog-box nil)

(when (bound-and-true-p tooltip-mode)
  (tooltip-mode -1))

(setq gc-cons-threshold 100000000)
(setq process-adaptive-read-buffering nil)
(setq read-process-output-max (* 4 1024 1024))

(setq x-gtk-use-system-tooltips nil)
(set-fringe-mode 10)
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font Mono" :height 100 :weight 'Bold)


;; Load use-package

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/use-package")
  (require 'use-package))

(setq use-package-always-ensure t)

(global-set-key (kbd "C-c C-c") 'keyboard-escape-quit)

(use-package ansi-color
  :ensure t
  :config (progn 
            (defun my/ansi-colorize-buffer ()
              (let ((buffer-read-only nil))
                (ansi-color-apply-on-region (point-min) (point-max))))
            (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)))

(visual-line-mode)

(use-package undo-tree
  :init
  :config
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))

(use-package general)

(use-package no-littering
  :ensure t
  :init)

(use-package smooth-scrolling)
(smooth-scrolling-mode 1)

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package all-the-icons
  :disable
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :disable
  :if (display-graphic-p)
  :after all-the-icons
  :hook (marginalia-mode . all-the-icons-completion-mode))

(use-package expand-region
  :ensure t
  :init)
