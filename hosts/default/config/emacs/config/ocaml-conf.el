(use-package tuareg
  :ensure t
  :hooks ((tuareg-mode . (lambda ()
			  (setq-local comment-style 'multi-line)
			  (setq-local comment-continue "   ")))
	  (tuareg-mode . merlin-mode)
	  )
  :init
 )
