;;; package --- Summary
;;; Code:
;;; Commentary:

;; Set up ELPA, MELPA, and Org package repositories and load =use-package= to manage package configuration.

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("melpa-stable" . "https://stable.melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(eval-when-compile
    (require 'use-package))

(setq use-package-always-ensure t)

(require 'org)
(org-babel-load-file
 (expand-file-name "~/dotfiles/emacs/my-org-init.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(helm-minibuffer-history-key "M-p")
 '(initial-frame-alist '((fullscreen . maximized)))
 '(js2-strict-inconsistent-return-warning nil)
 '(package-selected-packages
   '(vimish-fold visual-fill-column python-mode helm-lsp evil-collection json-mode general org org-bullets orgit origami markdown-mode helm-rg yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode helm-projectile ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide prettier-js helm exec-path-from-shell evil-visual-mark-mode company))
 '(savehist-mode t)
 '(treemacs-no-png-images t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))
 '(flycheck-locate-config-file-functions '(flycheck-locate-config-file-ancestor-directories flycheck-locate-config-file-by-path))
 '(flycheck-posframe-background-face ((t nil)))
 '(flycheck-posframe-border-face ((t (:foreground "light green"))))
 '(flycheck-posframe-info-face ((t (:inherit flycheck-posframe-face :foreground "SpringGreen2"))))
 '(helm-rg-file-match-face ((t (:foreground "MediumOrchid1"))))
 '(variable-pitch ((t (:family "Cantarell")))))

;;; Above this point, don't edit

(provide 'init)
;;; init.el ends here
