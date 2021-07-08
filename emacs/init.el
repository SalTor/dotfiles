;;; package --- Summary
;;; Code:
;;; Commentary:

;; Set up ELPA, MELPA, and Org package repositories and load =use-package= to manage package configuration.

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
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
 '(avy-keys
   '(104 107 108 121 117 105 111 112 110 109 44 113 119 101 114 116 122 120 99 118 98 97 115 100 103 106 102 59))
 '(company-frontends
   '(company-tng-frontend company-echo-metadata-frontend company-pseudo-tooltip-frontend))
 '(consult-ripgrep-command
   "rg --files --heading --hidden --follow --smart-case --sort path")
 '(consult-themes nil)
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(dashboard-startup-banner "~/Downloads/overcome.jpeg")
 '(dired-use-ls-dired 'unspecified)
 '(eglot-send-changes-idle-time 1)
 '(evil-split-window-below t)
 '(evil-undo-system 'undo-fu)
 '(evil-vsplit-window-right t)
 '(exec-path-from-shell-arguments '("-l"))
 '(flycheck-flake8rc '(".flake8"))
 '(flycheck-posframe-border-width 10)
 '(flycheck-posframe-error-prefix "■ ")
 '(flycheck-posframe-info-prefix "■ ")
 '(flycheck-posframe-prefix "■ ")
 '(flycheck-posframe-warning-prefix "■ ")
 '(helm-candidate-number-limit 200)
 '(helm-minibuffer-history-key "M-p")
 '(helm-rg-thing-at-point nil)
 '(helm-split-window-default-side 'below)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(ivy-height 20)
 '(ivy-height-alist
   '((counsel-evil-registers . 5)
     (counsel-yank-pop . 5)
     (counsel-git-log . 4)))
 '(js2-strict-inconsistent-return-warning nil)
 '(lsp-auto-execute-action nil)
 '(lsp-symbol-highlighting-skip-current t)
 '(package-selected-packages
   '(smart-mode-line mini-modeline quelpa yapfify virtualenv pylint markdown-preview-mode dap-chrome dap-mode deft whitespace-cleanup-mode whitespace-cleanup modus-vivendi-theme fzf mini-frame orderless org-roam solarized-theme moody tabbar theme-looper ripgrep embark marginalia all-the-icons-ibuffer esup consult flymake-flycheck undo-fu flymake-posframe eglot flx wgrep magit pyenv-mode volatile-highlights all-the-icons-ivy winum vimish-fold visual-fill-column python-mode evil-collection json-mode general org org-bullets orgit origami markdown-mode yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide prettier-js exec-path-from-shell evil-visual-mark-mode company))
 '(persp-set-last-persp-for-new-frames nil)
 '(persp-state-default-file "~/.config/emacs/persp-mode-save" nil nil "Customized with use-package perspective")
 '(savehist-mode t)
 '(show-trailing-whitespace nil)
 '(treemacs-no-png-images t)
 '(vterm-buffer-name "*vterm*")
 '(vterm-buffer-name-string "vterm %s"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-yank-face ((t (:inherit evil-goggles-default-face :background "DarkOrange1"))))
 '(flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))
 '(flycheck-locate-config-file-functions '(flycheck-locate-config-file-ancestor-directories flycheck-locate-config-file-by-path))
 '(flycheck-posframe-background-face ((t nil)))
 '(flycheck-posframe-border-face ((t (:foreground "light green"))))
 '(flycheck-posframe-info-face ((t (:inherit flycheck-posframe-face :foreground "SpringGreen2"))))
 '(helm-rg-file-match-face ((t (:foreground "MediumOrchid1"))))
 '(line-number ((t (:inherit default :foreground "#665c54" :strike-through nil :underline nil :slant normal :weight normal :height 130 :family "Source Code Pro"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :background "#3c3836" :foreground "#bdae93" :strike-through nil :underline nil :slant normal :weight bold :height 130 :family "Source Code Pro"))))
 '(lsp-details-face ((t (:inherit shadow :height 0.8 :family "Source Code Pro"))))
 '(mode-line-inactive ((t (:background "#504945" :foreground "#dfd2b8" :box nil))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro" :height 1.5 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro" :height 1.4))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro" :height 1.3))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro" :height 1.05))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro" :height 1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#ebdbb2" :font "Source Sans Pro"))))
 '(variable-pitch ((t (:family "ETBembo" :height 180 :weight regular)))))

;;; Above this point, don't edit

(provide 'init)
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
