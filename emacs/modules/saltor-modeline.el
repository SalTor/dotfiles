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
    (cogent-line-evil-insert "deep sky blue" "Evil insert state face.")
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
  (eval `(defface ,(intern (concat (symbol-name (nth 0 s)) "-buffer-name"))
           (list (list t (list :foreground ,(nth 1 s)
                               :background nil)))
           ,(nth 2 s)
           :group 'cogent)))

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
(defvar cogent/evil-state-faces-buffer-name
  '((normal . cogent-line-evil-normal-buffer-name)
    (insert . cogent-line-evil-insert-buffer-name)
    (operator . cogent-line-evil-operator-buffer-name)
    (emacs . cogent-line-evil-emacs-buffer-name)
    (replace . cogent-line-evil-replace-buffer-name)
    (visual . cogent-line-evil-visual-buffer-name)
    (motion . cogent-line-evil-motion-buffer-name)))

(defun cogent/evil-state-face ()
  (if-let ((face (and
                  (bound-and-true-p evil-local-mode)
                  (assq evil-state
                        (if (cogent-line-selected-window-active-p)
                            cogent/evil-state-faces
                          cogent/evil-state-faces-inactive)))))
      (cdr face)
    cogent-line-default-face))

(defun cogent/evil-state-face-buffer-name ()
  (if-let ((face (and
                  (bound-and-true-p evil-local-mode)
                  (assq evil-state
                        (if (cogent-line-selected-window-active-p)
                            cogent/evil-state-faces-buffer-name
                          cogent/evil-state-faces-inactive)))))
      (cdr face)
    cogent-line-default-face))

;; Keep track of selected window, so we can render the modeline differently
(defvar cogent-line-selected-window (frame-selected-window))
(defun cogent-line-set-selected-window (&rest _args)
  (when (not (minibuffer-window-active-p (frame-selected-window)))
    (setq cogent-line-selected-window (frame-selected-window))
    (force-mode-line-update)))
(defun cogent-line-unset-selected-window ()
  (setq cogent-line-selected-window nil)
  (force-mode-line-update))
(add-hook 'window-configuration-change-hook #'cogent-line-set-selected-window)
(add-hook 'focus-in-hook #'cogent-line-set-selected-window)
(add-hook 'focus-out-hook #'cogent-line-unset-selected-window)
(advice-add 'handle-switch-frame :after #'cogent-line-set-selected-window)
(add-hook 'window-selection-change-functions #'cogent-line-set-selected-window)
(defun cogent-line-selected-window-active-p ()
  (eq cogent-line-selected-window (selected-window)))

(setq-default
 mode-line-format
 '((:eval
    (simple-mode-line-render
     ;; left side
     (quote (" "
             (:eval (propertize (if (cogent-line-selected-window-active-p)
                                    (concat " " evil-mode-line-tag " ")
                                  (concat " " (s-repeat 6 "-") " ")) 'face (cogent/evil-state-face)))
             " "
             ;; File/buffer name
             (:eval (propertize "%b" 'face (cogent/evil-state-face-buffer-name)))
             ;; Shows "[+]" if file is modified
             (:eval
              (if buffer-file-name
                  (if (buffer-modified-p)
                      " [+] "
                    " ")))
             ;; Indicates if file is read-only
             (:eval
              (if buffer-file-name
                  (if buffer-read-only
                      " [read only] "
                    " ")))
             "%e "
             mode-line-process
             ))

     ;; right side
     (quote (
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
