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

(defvar ml-selected-window nil)

(defun ml-record-selected-window ()
  (setq ml-selected-window (selected-window)))

(add-hook 'post-command-hook 'ml-record-selected-window)

(defun is-active-buffer ()
  (eq ml-selected-window (selected-window)))
(defun hide-scroll-lines-etc ()
  (interactive)
  (or (eq major-mode 'org-mode)
      (eq major-mode 'dashboard-mode)
      (eq major-mode 'vterm-mode)
      (eq major-mode 'magit-status-mode)
      (eq major-mode 'magit-log-mode)
      ))

(defun get-lines-and-scroll-pos ()
  (interactive)
  (quote (
          ;; Cursor line, total lines, cursor column
          (:eval (when line-number-mode
                    "%l"))
          (:eval (when column-number-mode
                    ",%c "))
          ;; Percentage down in file that the line is
          (:eval (when line-number-mode
                   (let ((str ""))
                     (if my-mode-line-buffer-line-count
                         (setq str (concat str "☰ " (int-to-string (floor (* (/ (string-to-number (concat (format-mode-line "%l") ".0")) my-mode-line-buffer-line-count) 100))) "%% ")))
                     str)))
          )))

(setq-default
 mode-line-format
 '((:eval
    (simple-mode-line-render
     ;; left side
     (quote (
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
     (quote (
             (:eval (boundp 'pyvenv-virtual-env-name))
             ;; (vc-working-revision (buffer-file-name (current-buffer)))
             " "
             ;; lines, scroll position
             (:eval (if (hide-scroll-lines-etc)
                        ""
                      (get-lines-and-scroll-pos)
                      ))
             ;; Condense list of modes into "(Major-mode ;-)"
             minions-mode-line-modes
             " "
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
