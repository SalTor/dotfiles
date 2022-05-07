(defun sal-agenda-setup ()
  "Some bindings for org agenda mode"
  (print "Loaded org-agenda-functions")

  (define-key org-agenda-mode-map "c" 'org-capture)
  (define-key org-agenda-mode-map "x" 'org-agenda-archive-default-with-confirmation)
  (define-key org-agenda-mode-map "j" 'org-agenda-next-item)
  (define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
  (define-key org-agenda-mode-map "J" 'air-org-agenda-next-header)
  (define-key org-agenda-mode-map "K" 'air-org-agenda-previous-header)
  (remove-hook 'org-agenda-mode-hook 'sal-agenda-setup))

(defun sal/org-mode-setup ()
  "Org mode setup."
  (global-linum-mode 0))

(defun air-org-agenda-capture (&optional vanilla)
  "Capture a task in agenda mode, using the date at point.

  If VANILLA is non-nil, run the standard `org-capture'."
  (interactive "P")
  (if vanilla
    (org-capture)
    (let ((org-overriding-default-time (org-get-cursor-date)))
      (org-capture nil "t"))))

(defun air-pop-to-org-agenda (&optional split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda nil "d")
  (when (not split)
    (delete-other-windows)))

(defun air-org-agenda-next-header ()
  "Jump to the next header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header))

(defun air-org-agenda-previous-header ()
  "Jump to the previous header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header t))

(defun air--org-agenda-goto-header (&optional backwards)
  "Find the next agenda series header forwards or BACKWARDS."
  (let ((pos (save-excursion
               (goto-char (if backwards
                            (line-beginning-position)
                            (line-end-position)))
               (let* ((find-func (if backwards
                                   'previous-single-property-change
                                   'next-single-property-change))
                       (end-func (if backwards
                                   'max
                                   'min))
                       (all-pos-raw (list (funcall find-func (point) 'org-agenda-structural-header)
                                      (funcall find-func (point) 'org-agenda-date-header)))
                       (all-pos (cl-remove-if-not 'numberp all-pos-raw))
                       (prop-pos (if all-pos (apply end-func all-pos) nil)))
                 prop-pos))))
    (if pos (goto-char pos))
    (if backwards (goto-char (line-beginning-position)))))

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
         (pri-value (* 1000 (- org-lowest-priority priority)))
         (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
      subtree-end
      nil)))

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
      subtree-end
      nil)))
