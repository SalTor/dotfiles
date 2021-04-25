;;; package --- Summary
;;; Commentary:
;;; Code:
(add-to-list 'default-frame-alist '(font . "Source Code Pro-13"))

(setq byte-compile-warnings '(cl-functions))
(setq inhibit-startup-message t)
(setq backup-directory-alist '(("." . "~/.config/emacs/.saves"))) ;; Backup files in ~/.saves

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)
    (set-face-background 'hl-line (face-attribute 'mode-line :background))
(show-paren-mode 1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))

(defun insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))

;; (defvar ido-enable-flex-matching t)
;; (defvar ido-everywhere t)
;; (ido-mode 1)

(provide 'early-init)
;;; early-init.el ends here
