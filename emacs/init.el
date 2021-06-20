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
 '(centaur-tabs-mode t nil (centaur-tabs))
 '(centaur-tabs-show-new-tab-button nil)
 '(company-frontends
   '(company-tng-frontend company-echo-metadata-frontend company-pseudo-tooltip-frontend))
 '(consult-ripgrep-command
   "rg --files --heading --hidden --follow --smart-case --sort path")
 '(custom-safe-themes
   '("75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(dashboard-startup-banner "~/Downloads/overcome.jpeg")
 '(dired-use-ls-dired 'unspecified)
 '(doom-modeline-buffer-file-name-style 'relative-to-project)
 '(doom-modeline-modal-icon nil)
 '(eglot-send-changes-idle-time 1)
 '(evil-split-window-below t)
 '(evil-undo-system 'undo-fu)
 '(evil-vsplit-window-right t)
 '(exec-path-from-shell-arguments '("-l"))
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
 '(package-selected-packages
   '(all-the-icons-ibuffer esup consult flymake-flycheck undo-fu flymake-posframe eglot flx wgrep magit pyenv-mode volatile-highlights all-the-icons-ivy winum vimish-fold visual-fill-column python-mode evil-collection json-mode general org org-bullets orgit origami markdown-mode yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide prettier-js exec-path-from-shell evil-visual-mark-mode company))
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
 '(lsp-details-face ((t (:inherit shadow :height 0.8 :family "Source Code Pro")))))

;;; Above this point, don't edit

(provide 'init)
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
