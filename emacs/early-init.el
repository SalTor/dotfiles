(setq byte-compile-warnings '(cl-functions))
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Backup files in ~/.saves
(setq backup-directory-alist '(("." . "~/.config/emacs/.saves")))

(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(ido-mode t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(show-paren-mode 1)

;; https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-does-doom-start-up-so-quickly
    (setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
        gc-cons-percentage 0.6)

    (add-hook 'emacs-startup-hook
    (lambda ()
        (setq gc-cons-threshold 16777216 ; 16mb
            gc-cons-percentage 0.1)))

    (defun doom-defer-garbage-collection-h ()
    (setq gc-cons-threshold most-positive-fixnum))

    (defun doom-restore-garbage-collection-h ()
    ;; Defer it so that commands launched immediately after will enjoy the
    ;; benefits.
    (run-at-time
    1 nil (lambda () (setq gc-cons-threshold doom-gc-cons-threshold))))

    (add-hook 'minibuffer-setup-hook #'doom-defer-garbage-collection-h)
    (add-hook 'minibuffer-exit-hook #'doom-restore-garbage-collection-h)
