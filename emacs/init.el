;;; package --- Summary
;;; Code:
;;; Commentary:

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
 '(flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))
 '(flycheck-locate-config-file-functions
   '(flycheck-locate-config-file-ancestor-directories flycheck-locate-config-file-by-path))
 '(helm-always-two-windows t)
 '(helm-autoresize-max-height 50)
 '(helm-autoresize-min-height 50)
 '(helm-autoresize-mode t)
 '(helm-completion-style 'emacs)
 '(helm-minibuffer-history-key "M-p")
 '(initial-frame-alist '((fullscreen . maximized)))
 '(js2-strict-inconsistent-return-warning nil)
 '(package-selected-packages
   '(visual-fill-column python-mode helm-lsp evil-collection json-mode flycheck-inline general org org-bullets orgit origami markdown-mode helm-rg yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode helm-projectile ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide prettier-js helm exec-path-from-shell evil-visual-mark-mode company))
 '(savehist-mode t)
 '(treemacs-no-png-images t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-default-face ((t (:inherit 'helm-header-line-left-margin))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit tool-bar))))
 '(hl-line ((t (:extend t :background "#21242b"))))
 '(variable-pitch ((t (:family "Cantarell")))))

;;; Above this point, don't edit

(provide 'init)
;;; init.el ends here
