;;; package --- Summary
;;; Commentary:
;;; Code:
(setq byte-compile-warnings '(cl-functions))
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Backup files in ~/.saves
(setq backup-directory-alist '(("." . "~/.config/emacs/.saves")))

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(show-paren-mode 1)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-13"))

(defun ace-jump-two-chars-mode (query-char query-char-2)
  "Acejump Two Char Mode with QUERY-CHAR and QUERY-CHAR-2."
  (interactive (list (read-char "First Char:")
                     (read-char "Second:")))

  (if (eq (ace-jump-char-category query-char) 'other)
    (error "[AceJump] Non-printable character"))

  ;; others : digit , alpha, punc
  (let ((query-string (cond ((eq query-char-2 ?\r)
                 (format "%c" query-char))
                (t
                 (format "%c%c" query-char query-char-2)))))
    (defvar ace-jump-query-char query-char)
    (defvar ace-jump-current-mode 'ace-jump-char-mode)
    (ace-jump-do (regexp-quote query-string))))

;; https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-does-doom-start-up-so-quickly
    ; (setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
        ; gc-cons-percentage 0.6)
;
    ; (add-hook 'emacs-startup-hook
    ; (lambda ()
        ; (setq gc-cons-threshold 16777216 ; 16mb
            ; gc-cons-percentage 0.1)))
;
    ; (defun doom-defer-garbage-collection-h ()
    ; (setq gc-cons-threshold most-positive-fixnum))
;
    ; (defun doom-restore-garbage-collection-h ()
    ; ;; Defer it so that commands launched immediately after will enjoy the
    ; ;; benefits.
    ; (run-at-time
    ; 1 nil (lambda () (setq gc-cons-threshold doom-gc-cons-threshold))))
;
    ; (add-hook 'minibuffer-setup-hook #'doom-defer-garbage-collection-h)
    ; (add-hook 'minibuffer-exit-hook #'doom-restore-garbage-collection-h)
(provide 'early-init)
;;; early-init.el ends here
