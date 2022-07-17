;;; package --- Summary
;;; Code:
;;; Commentary:

;; Set up ELPA, MELPA, and Org package repositories and load =use-package= to manage package configuration.

(setq package-enable-at-startup nil)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

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
     '("076ee9f2c64746aac7994b697eb7dbde23ac22988d41ef31b714fc6478fee224" "f0eb51d80f73b247eb03ab216f94e9f86177863fb7e48b44aacaddbfe3357cf1" "db5b906ccc66db25ccd23fc531a213a1afb500d717125d526d8ff67df768f2fc" "2c40f89d1a0a9bcdfe1c6306991165de3b593cca0ae59e1164a0fb574424e6f2" "2b502f6e3bf0cba42fe7bf83a000f2d358a7020a7780a8682fcfed0c9dbffb5f" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "0fe24de6d37ea5a7724c56f0bb01efcbb3fe999a6e461ec1392f3c3b105cc5ac" "08a27c4cde8fcbb2869d71fdc9fa47ab7e4d31c27d40d59bf05729c4640ce834" "aaa4c36ce00e572784d424554dcc9641c82d1155370770e231e10c649b59a074" "5379937b99998e0510bd37ae072c7f57e26da7a11e9fb7bced8b94ccc766c804" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "0685ffa6c9f1324721659a9cd5a8931f4bb64efae9ce43a3dba3801e9412b4d8" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(dashboard-startup-banner "~/dotfiles/emacs/assets/overcome.jpeg")
 '(dired-use-ls-dired 'unspecified)
 '(eglot-send-changes-idle-time 1)
 '(exec-path-from-shell-arguments '("-l"))
 '(flycheck-posframe-border-width 10)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(js2-strict-inconsistent-return-warning nil)
 '(lsp-auto-execute-action nil)
 '(lsp-diagnostics-provider :flycheck)
 '(lsp-symbol-highlighting-skip-current t)
 '(modus-themes-fringes nil)
 '(org-cycle-separator-lines -1)
  '(package-selected-packages
     '(perspective editorconfig quelpa yapfify virtualenv pylint markdown-preview-mode dap-chrome dap-mode deft whitespace-cleanup-mode whitespace-cleanup modus-vivendi-theme fzf mini-frame orderless org-roam solarized-theme tabbar theme-looper ripgrep embark marginalia all-the-icons-ibuffer esup consult flymake-flycheck undo-fu flymake-posframe eglot flx wgrep magit pyenv-mode volatile-highlights all-the-icons-ivy winum vimish-fold visual-fill-column python-mode evil-collection json-mode general org org-bullets orgit origami markdown-mode yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide exec-path-from-shell evil-visual-mark-mode company))
 '(persp-modestring-short t)
 '(persp-set-last-persp-for-new-frames nil)
 '(persp-show-modestring ''header)
 '(savehist-mode t)
 '(show-trailing-whitespace nil)
 '(tramp-histfile-override nil)
 '(treemacs-indentation-string "  ")
 '(treemacs-no-png-images t)
 '(typescript-indent-level 4)
 '(vterm-buffer-name "*vterm*")
 '(widget-image-enable nil)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Source Code Pro" :height 130 :weight regular))))
 '(flycheck-posframe-background-face ((t nil)))
 '(flycheck-posframe-border-face ((t (:foreground "light green"))))
 '(flycheck-posframe-info-face ((t (:inherit flycheck-posframe-face :foreground "SpringGreen2"))))
 '(helm-rg-file-match-face ((t (:foreground "MediumOrchid1"))))
 '(lsp-details-face ((t (:inherit shadow :height 0.8 :family "Source Code Pro"))))
 '(nano-modeline-active-secondary ((t (:inherit nano-modeline-active))))
 '(nano-modeline-inactive ((t (:inherit mode-line-inactive))))
 '(variable-pitch ((t (:family "Lucida Grande" :height 150 :weight thin)))))

;;; Above this point, don't edit

(provide 'init)
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
