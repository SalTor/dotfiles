;;; package --- Summary
;;; Code:
;;; Commentary:
(use-package selectrum
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :config
  ;; to make sorting and filtering more intelligent
  (selectrum-prescient-mode +1)

  ;; to save your command history on disk, so the sorting gets more
  ;; intelligent over time
  (prescient-persist-mode +1))

(use-package ripgrep)

(use-package general
  :after evil
  :config
  (leader-keys
    "x" 'execute-extended-command
    ";" 'consult-buffer
    "," 'projectile-find-file
    "sp" 'projectile-ripgrep))

;; Adds additional meta data to candidates
(use-package marginalia
  :after evil
  :config
  (add-to-list 'marginalia-prompt-categories '("Find file" . file))
  (marginalia-mode))

(defun sal-split-right ()
  (interactive)
  (projectile--find-file (selectrum-get-current-candidate))
  (split-window-horizontally)
  (evil-switch-to-windows-last-buffer)
  (other-window 1)
  )

(defun sal-split-below ()
  (interactive)
  (projectile--find-file (selectrum-get-current-candidate))
  (split-window-below)
  (evil-switch-to-windows-last-buffer)
  (other-window 1)
  )

;; Better control over actions in the minibuffer
(use-package embark
  :bind (("C-." . embark-act))
  :config
  (embark-define-keymap sal-embark-file-map
    "Keymap for actions for tab-bar tabs (when mentioned by name)."
    ("-" sal-split-below)
    ("/" sal-split-right))
  (add-to-list 'embark-keymap-alist '(file . sal-embark-file-map))

  (setq embark-action-indicator
        (lambda (map _target)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator)
  )

;; (define-key embark-file-map (kbd "r") 'rename-file)

(provide 'conf-selectrum)
;;; conf-selectrum.el ends here
