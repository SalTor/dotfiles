;;; package --- Summary
;;; Code:
;;; Commentary:
(use-package ivy
  :config
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-initial-inputs-alist nil) ;; no regexp by default
  (setq ivy-re-builders-alist ;; configure regexp engine.
        '((t   . ivy--regex-ignore-order))) ;; allow input not in order
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
         ("C-d" . ivy-reverse-i-search-kill)))

(use-package general
  :after evil
  :config
  (leader-keys
    ";" 'ivy-switch-buffer))

(use-package all-the-icons)

(use-package all-the-icons-ibuffer
  :defer 2
  :init (all-the-icons-ibuffer-mode 1))

(use-package all-the-icons-ivy-rich
  :defer 2
  :after ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :defer 2
  :after ivy
  :config
  (setq ivy-virtual-abbreviate 'abbreviate
        ivy-rich-path-style 'abbrev)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (ivy-rich-mode 1))

(use-package ivy-prescient
  :defer 2
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  (ivy-prescient-sort-commands '(:not swiper swiper-isearch ivy-switch-buffer counsel-projectile-find-file))
  :config
  (prescient-persist-mode 1) ;; Remember sorting across sessions
  (ivy-prescient-mode 1))

(use-package counsel
  :custom
  (counsel-switch-buffer-preview-virtual-buffers nil)
  :config
  (counsel-mode 1)
  (leader-keys "x" 'counsel-M-x))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package general
  :after evil
  :config
  (leader-keys
    "," 'counsel-projectile-find-file))

(provide 'conf-ivy)
;;; conf-ivy.el ends here
