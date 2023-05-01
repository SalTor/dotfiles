(defun sal-split-right ()
  (interactive)
  (projectile--find-file (selectrum-get-current-candidate))
  (split-window-horizontally)
  (evil-switch-to-windows-last-buffer)
  (other-window 1))

(defun sal-split-below ()
  (interactive)
  (projectile--find-file (selectrum-get-current-candidate))
  (split-window-below)
  (evil-switch-to-windows-last-buffer)
  (other-window 1))

(defun sal-cd-project-root ()
  (if (projectile-project-root)
    (cd (projectile-project-root))))

(defun sal-enable-linum ()
  (interactive)
  (if (eq nil display-line-numbers)
    (setq display-line-numbers 'absolute)
    (message "Linum mode set")))

(defun sal-switch-linum-mode ()
  (interactive)
  (if (eq 'relative display-line-numbers)
    (setq display-line-numbers 'absolute)
    (setq display-line-numbers 'relative)))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name)))

(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))

(defun insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))

(defun kill-magit-diff-buffer-in-current-repo (&rest _)
  "Delete the magit-diff buffer related to the current repo"
  (let ((magit-diff-buffer-in-current-repo
          (magit-mode-get-buffer 'magit-diff-mode)))
    (kill-buffer magit-diff-buffer-in-current-repo)))

(defun ibuffer-jump-to-last-buffer ()
  (ibuffer-jump-to-buffer (buffer-name (cadr (buffer-list)))))

(defun sal-display-startup-time ()
  "Display startup time. Displayed in Dashboard"
  (message "Emacs loaded in %s with %d garbage collections."
    (format "%.2f seconds"
      (float-time
        (time-subtract after-init-time before-init-time)))
    gcs-done))

(defun sal/set-font-faces ()
  (message "[sal] Setting font faces")

  (set-face-attribute 'default nil
    :font "JetBrains Mono" :weight 'regular :height 130)
    ;; :font "Roboto Mono" :weight 'regular :height 130)
  ;; (set-face-attribute 'default nil
  ;; :family "Roboto Mono" :weight 'light :height 130)
  (set-face-attribute 'bold nil
    :family "JetBrains Mono" :weight 'regular)
    ;; :family "Roboto Mono" :weight 'regular)
  (set-face-attribute 'italic nil
    :family "Victor Mono" :weight 'light :slant 'italic)
  ;; (set-fontset-font t 'symbol "Apple Color Emoji")
  ;; (set-fontset-font t 'unicode
  ;;   (font-spec :name "Hack Nerd Font" :size 16) nil 'prepend)
  ;; (set-fontset-font t '(#xe000 . #xffdd)
  ;;   (font-spec :name "Hack Nerd Font" :size 12) nil)
  ;; Use 'prepend for the NS and Mac ports or Emacs will crash.

  (message "[sal] ☑ Font faces set"))
