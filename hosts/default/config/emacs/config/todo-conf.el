(use-package hl-todo
  :ensure t
  :init (global-hl-todo-mode)
  :config
    (setq hl-todo-keyword-faces
	'(("TODO"    . "#eba0ac")
	    ("FIXME"   . "#f38ba8")
	    ("DEBUG"   . "#f38ba8")
	    ("XXX"     . "#f38ba8")
	    ("CHECK"   . "#94e2d5")
	    ("PERF"    . "#f9e2af")
	    ("NOTE"    . "#a6e3a1")
	    ("IMPO"    . "#a6e3a1")
	    )))
