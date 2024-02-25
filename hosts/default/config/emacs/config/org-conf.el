(defun increment-num (num-to-add)
    (interactive "nIncrement by: ")

    (let ((bounds (bounds-of-thing-at-point 'number))
	  (current-number (thing-at-point 'number t)))
      (when bounds
	(delete-region (car bounds) (cdr bounds))
	(insert (number-to-string (+ current-number num-to-add))))))


(defun insert-yt-timestamp (video-timestamp-string)

  (interactive "sVideo timestamp (hh:mm:ss): ")

  (let* ( (video-links (org-property-values "VIDEO"))
	  (video-timestamp (mapcar #'string-to-number (split-string video-timestamp-string ":")))
	  (timestamp-hrs (nth 0 video-timestamp))
	  (timestamp-mins (nth 1 video-timestamp))
	  (timestamp-sec (nth 2 video-timestamp))
	  (total-time (+ (* timestamp-hrs 3600)
			 (* timestamp-mins 60)
			 timestamp-sec))
	  )

    (when video-links
      (insert 
       (format " [[%s][%s]]:" 
	       (concat "" (car video-links) "&t=" (number-to-string total-time))
	       video-timestamp-string)))))


(use-package org-mode
  :defer t
  :ensure t
  :after evil evil-collection
  :hook ( ("\\.org\\" . org-mode)
	  (org-mode . org-indent-mode)
	  (org-mode . org-pretty-tags-mode)
	  (org-mode . company-mode)
	  )
  :init 
    (require 'org)
    (require 'org-element)
  :config
  (setq org-startup-indented t)
  (setq org-indent-indentation-per-level 0))

;; https://www.youtube.com/watch?v=WnBXLmKk_qw&t=2324s
(defun org-mode-mappings ()
  (evil-define-key 'normal 'org-mode-map (kbd "C-a C-s") 'org-fold-show-entry)
  (evil-define-key 'normal 'org-mode-map (kbd "C-a C-h") 'org-fold-hide-entry)
  (evil-define-key 'normal 'org-mode-map (kbd "C-a C-i") 'increment-num)
  (evil-define-key 'normal 'org-mode-map (kbd "C-a C-t") 'insert-yt-timestamp)
  )

(use-package org-pretty-tags
  :ensure t
  :defer t)
