;;; package --- Summary
;;; Code:
;;; Commentary:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centaur-tabs-style 'wave)
 '(custom-safe-themes
   '("83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(evil-undo-system 'undo-tree)
 '(evil-want-C-u-scroll t)
 '(evil-want-Y-yank-to-eol t)
 '(flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))
 '(flycheck-locate-config-file-functions
   '(flycheck-locate-config-file-ancestor-directories flycheck-locate-config-file-by-path))
 '(helm-always-two-windows t)
 '(helm-autoresize-max-height 50)
 '(helm-autoresize-min-height 50)
 '(helm-autoresize-mode t)
 '(helm-completion-style 'emacs)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(js2-strict-inconsistent-return-warning nil)
 '(package-selected-packages
   '(json-mode flycheck-inline general org org-bullets orgit origami markdown-mode helm-rg yaml-mode lua-mode treemacs-evil treemacs-projectile evil-surround evil-nerd-commenter ## evil-goggles evil-leader drag-stuff vimrc-mode helm-projectile ag projectile-ripgrep selectrum-prescient selectrum ido company-quickhelp-terminal rjsx web-mode-edit-element use-package undo-tree tide prettier-js helm exec-path-from-shell evil-visual-mark-mode company))
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
 '(evil-goggles-yank-face ((t (:inherit tool-bar)))))

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;; Above this point, don't edit

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(use-package helm
  :ensure t
  :config (helm-mode 1))
(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

(use-package exec-path-from-shell
    :ensure t)

(use-package evil
  :ensure t
  :init
  (add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode))
(evil-set-initial-state 'Custom-mode 'normal)

(use-package evil-leader
  :ensure t
  :config (global-evil-leader-mode))

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "U") 'evil-redo)

(define-key evil-visual-state-map (kbd "J") 'drag-stuff-down)
(define-key evil-visual-state-map (kbd "K") 'drag-stuff-up)

(define-key evil-normal-state-map (kbd "gl") 'evil-end-of-line)

(define-key evil-normal-state-map (kbd "] SPC") 'insert-line-below)
(define-key evil-normal-state-map (kbd "[ SPC") 'insert-line-above)
(define-key evil-normal-state-map (kbd "C-n") 'next-error)
(define-key evil-normal-state-map (kbd "C-p") 'previous-error)
(define-key evil-normal-state-map (kbd "] b") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "[ b") 'centaur-tabs-backward)

(define-key key-translation-map (kbd "SPC x") 'helm-M-x)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Leader key
(evil-leader/set-leader "SPC")

;; Window
(evil-leader/set-key
    "wr" 'evil-window-rotate-upwards
    "w/" 'evil-window-vsplit
    "w-" 'evil-window-split
    "wh" 'evil-window-left
    "wj" 'evil-window-down
    "wk" 'evil-window-up
    "wl" 'evil-window-right)

;; Comments
(evil-leader/set-key
    "cc" 'comment-line)
(evil-leader/set-key-for-mode
    'evil-visual-state "cc" 'evilnc-comment-or-uncomment-lines)

;; Project
(evil-leader/set-key
  "ps" 'centaur-tabs-switch-group
  "po" 'projectile-switch-project)

;; Search
(evil-leader/set-key
    "sp" 'projectile-ripgrep "")

;; File
(evil-leader/set-key
    "fe" 'treemacs
    "fj" 'treemacs-find-file
    "fr" 'rename-file
    "f5" 'load-file
    "fs" 'save-buffer)

;; Buffer
(evil-leader/set-key
    "wq" 'delete-window
    "h" 'help-command
    "bd" 'kill-this-buffer
    "," 'projectile-find-file
    ";" 'projectile-switch-to-buffer
    "TAB" 'evil-switch-to-windows-last-buffer)

(use-package evil-nerd-commenter :ensure t)

(use-package evil-surround :ensure t :config (global-evil-surround-mode 1))

(use-package evil-goggles
  :ensure t
  :config
    (evil-goggles-mode)
    (setq evil-goggles-duration 0.500
          evil-goggles-blocking-duration 0.001
          evil-goggles-async-duration 0.900
          evil-goggles-enable-paste nil
          evil-goggles-enable-delete nil))

(use-package undo-tree
    :ensure t)

(use-package web-mode
    :ensure t)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
    (company-tng-mode)
    (setq company-idle-delay 0
          company-minimum-prefix-length 1
          company-selection-wrap-around t))

(use-package pos-tip
    :ensure t)
(use-package company-quickhelp
  :ensure t
  :config (company-quickhelp-mode))

(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'evil
         :init
         '(define-key evil-redo (kbd) "U"))
(evil-mode t)
(require 'web-mode)

(use-package telephone-line :ensure t :init (telephone-line-mode 1))

(use-package origami
  :ensure t
  :config (global-origami-mode))

(use-package doom-themes
  :ensure t
  :config
  (defvar doom-themes-treemacs-theme "doom-colors")
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
  ;; (doom-themes-treemacs-config) ;; Enable flashing mode-line on errors
  (doom-themes-org-config)) ;; Corrects (and improves) org-mode's native fontification.

(use-package all-the-icons :ensure t)

(use-package doom-modeline :ensure t :init (doom-modeline-mode 1))

(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (setq centaur-tabs-set-bar 'under
        x-underline-at-descent-line t
        centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-height 24
        centaur-tabs-style 'wave
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "•")
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-mode t)
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-set-heading-icons t
	;; dashboard-projects-switch-function 'projectile-switch-project
	dashboard-startup-banner 'logo
	dashboard-center-content nil
	dashboard-set-navigator t
        dashboard-set-file-icons t)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))
  (dashboard-setup-startup-hook))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-follow-mode nil
        treemacs-tag-follow-mode nil))
(use-package treemacs-projectile :ensure t)
(use-package treemacs-evil :ensure t)

(use-package which-key :ensure t :config (which-key-mode))

(use-package avy
  :ensure t)
(define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)

(use-package typescript-mode
  :ensure t
  :hook (typescript-mode . tide-setup))

(use-package rjsx-mode
    :ensure t
    :mode ("\\.jsx$" . rjsx-mode)
    :mode ("\\.tsx$" . rjsx-mode)
    :hook (rjsx-mode . tide-setup))

(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(defun setup-tide-mode ()
  "Set up tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (company-mode +1))

(use-package tide
  :ensure t
  :after (rjsx-mode company flycheck)
  :hook
  (rjsx-mode .  setup-tide-mode)
  (typecript-mode . setup-tide-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

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

(eval-after-load 'company
    '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(use-package prettier-js
  :ensure t
  :after (rjsx-mode)
  :hook (rjsx-mode . prettier-js-mode))

(defun dw/org-mode-setup()
  "Set up org mode."
  (org-indent-mode)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (org-bullets-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :ensure t
  :hook (org-mode . dw/org-mode-setup)
  :config
  (setq org-hide-emphasis-markers t))

(use-package org-bullets
  :ensure t)

(use-package general
  :ensure t)

(use-package helm
  :config
  ;; ... some other stuff
  ;; Enable opening helm results in splits
  (cl-macrolet
      ((make-splitter-fn (name open-fn split-fn)
                         `(defun ,name (_candidate)
                            ;; Display buffers in new windows
                            (dolist (cand (helm-marked-candidates))
                              (select-window (,split-fn))
                              (,open-fn cand))
                            ;; Adjust size of windows
                            (balance-windows)))
       (generate-helm-splitter-funcs
        (op-type open-fn)
        (let* ((prefix (s-concat "helm-" op-type "-switch-"))
               (vert-split (intern (s-concat prefix "vert-window")))
               (horiz-split (intern (s-concat prefix "horiz-window"))))
          `(progn
             (make-splitter-fn ,vert-split ,open-fn split-window-right)

             (make-splitter-fn ,horiz-split ,open-fn split-window-below)

             (defun ,(intern (s-concat "helm-" op-type "-switch-vert-window-command"))
                 ()
               (interactive)
               (with-helm-alive-p
                 (helm-exit-and-execute-action (quote ,vert-split))))

             (defun ,(intern (s-concat "helm-" op-type "-switch-horiz-window-command"))
                 ()
               (interactive)
               (with-helm-alive-p
                 (helm-exit-and-execute-action (quote ,horiz-split))))))))
    (generate-helm-splitter-funcs "buffer" switch-to-buffer)
    (generate-helm-splitter-funcs "file" find-file)

    ;; install the actions for helm-find-files after that source is
    ;; inited, which fortunately has a hook
    (add-hook
     'helm-find-files-after-init-hook
     (lambda ()
       (helm-add-action-to-source "Display file(s) in new vertical split(s) `C-v'"
                                  #'helm-file-switch-vert-window
                                  helm-source-find-files)
       (helm-add-action-to-source "Display file(s) in new horizontal split(s) `C-s'"
                                  #'helm-file-switch-horiz-window
                                  helm-source-find-files)))

    ;; ditto for helm-projectile; that defines the source when loaded, so we can
    ;; just eval-after-load
    (with-eval-after-load "helm-projectile"
      (helm-add-action-to-source "Display file(s) in new vertical split(s) `C-v'"
                                 #'helm-file-switch-vert-window
                                 helm-source-projectile-files-list)
      (helm-add-action-to-source "Display file(s) in new horizontal split(s) `C-s'"
                                 #'helm-file-switch-horiz-window
                                 helm-source-projectile-files-list))

    ;; ...but helm-buffers defines the source by calling an init function, but doesn't
    ;; have a hook, so we use advice to add the actions after that init function
    ;; is called
    (defun cogent/add-helm-buffer-actions (&rest _args)
      (helm-add-action-to-source "Display buffer(s) in new vertical split(s) `C-v'"
                                 #'helm-buffer-switch-vert-window
                                 helm-source-buffers-list)
      (helm-add-action-to-source "Display buffer(s) in new horizontal split(s) `C-s'"
                                 #'helm-buffer-switch-horiz-window
                                 helm-source-buffers-list))
    (advice-add 'helm-buffers-list--init :after #'cogent/add-helm-buffer-actions))
  :general
  (:keymaps 'helm-buffer-map
   "C-v" #'helm-buffer-switch-vert-window-command
   "C-s" #'helm-buffer-switch-horiz-window-command)
  (:keymaps 'helm-projectile-find-file-map
   "C-v" #'helm-file-switch-vert-window-command
   "C-s" #'helm-file-switch-horiz-window-command)
  (:keymaps 'helm-find-files-map
   "C-v" #'helm-file-switch-vert-window-command
   "C-s" #'helm-file-switch-horiz-window-command))

(use-package helm-rg
  :config
  (defun cogent/switch-to-buffer-split-vert (name)
    (select-window (split-window-right))
    (switch-to-buffer name))
  (defun cogent/switch-to-buffer-split-horiz (name)
    (select-window (split-window-below))
    (switch-to-buffer name))

  (defun cogent/helm-rg-switch-vert (parsed-output &optional highlight-matches)
    (let ((helm-rg-display-buffer-normal-method #'cogent/switch-to-buffer-split-vert))
      (helm-rg--async-action parsed-output highlight-matches)))
  (defun cogent/helm-rg-switch-horiz (parsed-output &optional highlight-matches)
    (let ((helm-rg-display-buffer-normal-method #'cogent/switch-to-buffer-split-horiz))
      (helm-rg--async-action parsed-output highlight-matches)))

  ;; helm-rg defines the source when it's loaded, so we can add the action
  ;; right away
  (helm-add-action-to-source
   "Open in horizontal split `C-s'" #'cogent/helm-rg-switch-horiz
   helm-rg-process-source)
  (helm-add-action-to-source
   "Open in vertical split `C-v'" #'cogent/helm-rg-switch-vert
   helm-rg-process-source)

  (defun cogent/helm-rg-switch-vert-command ()
    (interactive)
    (with-helm-alive-p
      (helm-exit-and-execute-action #'cogent/helm-rg-switch-vert)))
  (defun cogent/helm-rg-switch-horiz-command ()
    (interactive)
    (with-helm-alive-p
      (helm-exit-and-execute-action #'cogent/helm-rg-switch-horiz)))

  (general-def helm-rg-map
    "C-s" #'cogent/helm-rg-switch-horiz-command
    "C-v" #'cogent/helm-rg-switch-vert-command))

(provide 'init)
;;; init.el ends here
