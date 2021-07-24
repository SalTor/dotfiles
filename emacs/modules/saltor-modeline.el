;;; -*- lexical-binding: t -*-

(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length.
Containing LEFT, and RIGHT aligned respectively."
  (let ((available-width
         (- (window-total-width)
            (+ (length (format-mode-line left))
               (length (format-mode-line right))))))
    (append left
            (list (format (format "%%%ds" available-width) ""))
            right)))

(setq evil-normal-state-tag "NORMAL")
(setq evil-insert-state-tag "INSERT")
(setq evil-visual-state-tag "VISUAL")
(setq evil-replace-state-tag "REPLACE")
(setq evil-emacs-state-tag "EMACS")

(defvar cogent-line-active-bg "#34495e"
  "Modeline background colour for active window")

(defvar cogent-line-inactive-bg "#bfc4ca"
  "Modeline background colour for inactive window")

(defvar cogent-line-evil-state-colours
  '((cogent-line-evil-normal "#afd787" "Evil normal state face.")
    (cogent-line-evil-insert "#87afd7" "Evil insert state face.")
    (cogent-line-evil-emacs "SkyBlue2" "Evil emacs state face.")
    (cogent-line-evil-replace "chocolate" "Evil replace state face.")
    (cogent-line-evil-visual "plum3" "Evil visual state face.")
    (cogent-line-evil-motion "plum3" "Evil motion state face.")
    (cogent-line-evil-operator "plum3" "Evil operator state face.")
    (cogent-line-unmodified "DarkGoldenrod2" "Unmodified buffer face.")
    (cogent-line-modified "SkyBlue2" "Modified buffer face.")
    (cogent-line-highlight-face "DarkGoldenrod2" "Default highlight face."))
  "Names, initial colours, and docstring for Evil state modeline indicator")

(dolist (s cogent-line-evil-state-colours)
  (eval `(defface ,(nth 0 s)
           (list (list t (list :foreground "#504945"
                               :weight 'bold
                               :background ,(nth 1 s))))
           ,(nth 2 s)
           :group 'cogent))
  (eval `(defface ,(intern (concat (symbol-name (nth 0 s)) "-inactive"))
           (list (list t (list :foreground "#dfd2b8"
                               :background nil)))
           ,(nth 2 s)
           :group 'cogent))
    )

(defvar cogent/evil-state-faces
  '((normal . cogent-line-evil-normal)
    (insert . cogent-line-evil-insert)
    (operator . cogent-line-evil-operator)
    (emacs . cogent-line-evil-emacs)
    (replace . cogent-line-evil-replace)
    (visual . cogent-line-evil-visual)
    (motion . cogent-line-evil-motion)))
(defvar cogent/evil-state-faces-inactive
  '((normal . cogent-line-evil-normal-inactive)
    (insert . cogent-line-evil-insert-inactive)
    (operator . cogent-line-evil-operator-inactive)
    (emacs . cogent-line-evil-emacs-inactive)
    (replace . cogent-line-evil-replace-inactive)
    (visual . cogent-line-evil-visual-inactive)
    (motion . cogent-line-evil-motion-inactive)))

(defun cogent/evil-state-face ()
  (if-let ((face (and
                  (bound-and-true-p evil-local-mode)
                  (assq evil-state cogent/evil-state-faces))))
      (cdr face)
    cogent-line-default-face))

(defvar ml-selected-window nil)

(defun ml-record-selected-window ()
  (setq ml-selected-window (selected-window)))

(add-hook 'post-command-hook 'ml-record-selected-window)

(defun is-active-buffer ()
  (eq ml-selected-window (selected-window)))

(defun is-active-propertized (active-text &optional inactive-text)
  (interactive)
  (if (is-active-buffer)
      (propertize active-text 'face (cogent/evil-state-face))
    (if inactive-text
        inactive-text
      active-text)))

(setq-default
 mode-line-format
 '((:eval
    (simple-mode-line-render
     ;; left side
     (quote (
             (:eval (is-active-propertized
                     (concat " " evil-mode-line-tag " ")
                     " ------ "))
             " "
             "%b"
             ;; Shows if file is modified
             (:eval
              (if (and buffer-file-name (buffer-modified-p))
                  " [+] "
                " "))
             ;; Indicates if file is read-only
             (:eval
              (if buffer-read-only
                  " [RO] "
                " "))
             "%e "
             mode-line-process
             ))

     ;; right side
     (quote ((:eval (boundp 'pyvenv-virtual-env-name))
             (:eval (let ((salgitbranch (format-mode-line '(vc-mode vc-mode))))
                      (if (boundp 'salgitbranch)
                          (replace-regexp-in-string "Git[:|-]" "" salgitbranch))
                      )
                    )
             " "
             ;; Cursor line, total lines, cursor column
             (:eval (when line-number-mode
                      (let ((str "%l"))
                        (if my-mode-line-buffer-line-count
                            (setq str (concat str "," (int-to-string my-mode-line-buffer-line-count))))
                        str)))
             (column-number-mode "-%c ")
             ;; Percentage down in file that the line is
             (:eval (when line-number-mode
                      (let ((str ""))
                        (if my-mode-line-buffer-line-count
                            (setq str (concat str "☰ " (int-to-string (floor (* (/ (string-to-number (concat (format-mode-line "%l") ".0")) my-mode-line-buffer-line-count) 100))) "%% ")))
                        str)))
             ;; Condense list of modes into "(Major-mode ;-)"
             minions-mode-line-modes
             ))))))

(defun my-mode-line-count-lines ()
  "Count max lines in file."
  (setq my-mode-line-buffer-line-count (count-lines (point-min) (point-max))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)

(provide 'saltor-modeline)
;;; saltor-modeline.el ends here
