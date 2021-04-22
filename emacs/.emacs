(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(flycheck-locate-config-file-functions
   '(flycheck-locate-config-file-ancestor-directories flycheck-locate-config-file-by-path))
 '(js2-strict-inconsistent-return-warning nil)
 '(package-selected-packages
   '(ace-jump-mode rjsx web-mode-edit-element use-package undo-tree tide prettier-js helm exec-path-from-shell evil-visual-mark-mode company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-background ((t (:background "#32302f" :foreground "#32302f"))))
 '(ace-jump-face-foreground ((t nil))))

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(eval-when-compile
    (require 'use-package))

(use-package undo-tree
    :ensure t)

(use-package evil
    :ensure t)

(use-package web-mode
    :ensure t)

(use-package helm
    :ensure t)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package pos-tip
    :ensure t)

(use-package exec-path-from-shell
    :ensure t)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'evil)
    (evil-mode t)
(require 'web-mode)

(use-package telephone-line
    :ensure t)
(telephone-line-mode 1)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-13"))

(use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-one t)
    (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
    (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    (doom-themes-treemacs-config) ;; Enable flashing mode-line on errors
    (doom-themes-org-config)) ;; Corrects (and improves) org-mode's native fontification.

(use-package all-the-icons
    :ensure t)

(use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))

(use-package centaur-tabs
    :ensure t
    :demand
    :config
    (setq centaur-tabs-set-bar 'over
          centaur-tabs-set-icons t
          centaur-tabs-gray-out-icons 'buffer
          centaur-tabs-height 24
          centaur-tabs-set-modified-marker t
          centaur-tabs-modified-marker "•")
    (centaur-tabs-headline-match)
    (centaur-tabs-mode t))

(use-package dashboard
    :ensure t
    :config
    (setq dashboard-items '((recents . 5)
                            (projects . 5)))
    (dashboard-setup-startup-hook))

(use-package projectile
    :ensure t
    :config
    (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
    (projectile-mode +1))

(use-package treemacs
    :ensure t
    :bind
    (:map global-map
        ([f8] . treemacs))
    :config
    (progn
        (setq treemacs-is-never-other-window t)))

(use-package which-key
    :ensure t
    :config (which-key-mode))

(use-package ace-jump-mode
    :ensure t)

(setq ace-jump-mode-gray-background nil)

(autoload
    'ace-jump-mode
    "ace-jump-mode"
    "Emacs quick move minor mode"
    t)
(define-key evil-normal-state-map (kbd "s") 'ace-jump-mode)

(use-package rjsx-mode
    :ensure t
    :mode ("\\.jsx?$" . rjsx-mode)
    :mode ("\\.tsx?$" . rjsx-mode)
    :hook (rjsx-mode . tide-setup))

(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(use-package flycheck
    :ensure t)

;; Configure flycheck for javascript
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq flycheck-javascript-eslint-executable "eslint_d")

;; Disable jshint in favour of eslint
(setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
        '(javascript-jshint)))

;; use eslint with rjsx-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
        '(json-jsonlist)))

(defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (company-mode +1)
    )

(use-package tide
    :ensure t
    :after (rjsx-mode company flycheck)
    :hook (rjsx-mode . setup-tide-mode))

(use-package company-quickhelp
    :ensure t)

(company-quickhelp-mode)

(eval-after-load 'company
    '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(use-package prettier-js
    :ensure t
    :after (rjsx-mode)
    :hook (rjsx-mode . prettier-js-mode))

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
