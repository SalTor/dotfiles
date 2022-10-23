(defun sal-agenda-setup ()
  "Some bindings for org agenda mode"
  (print "Loaded org-agenda-functions")

  (define-key org-agenda-mode-map "c" 'org-capture)
  (define-key org-agenda-mode-map "x" 'org-agenda-archive-default-with-confirmation)
  (define-key org-agenda-mode-map "j" 'org-agenda-next-item)
  (define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
  (define-key org-agenda-mode-map "J" 'org-agenda-next-line)
  (define-key org-agenda-mode-map "K" 'org-agenda-previous-line)
  (define-key org-agenda-mode-map "D" 'org-agenda-goto-date)
  (define-key org-agenda-mode-map "\C-l" 'consult-org-agenda)
  (define-key org-agenda-mode-map "\C-k" nil)
  (remove-hook 'org-agenda-mode-hook 'sal-agenda-setup)
  )

(defun org-agenda-delete-empty-blocks ()
  "Remove empty agenda blocks.
  A block is identified as empty if there are fewer than 2
  non-empty lines in the block (excluding the line with
  `org-agenda-block-separator' characters)."
  (when org-agenda-compact-blocks
    (user-error "Cannot delete empty compact blocks"))
  (setq buffer-read-only nil)
  (save-excursion
    (goto-char (point-min))
    (let* ((blank-line-re "^\\s-*$")
            (content-line-count (if (looking-at-p blank-line-re) 0 1))
            (start-pos (point))
            (block-re (format "%c\\{10,\\}" org-agenda-block-separator)))
      (while (and (not (eobp)) (forward-line))
        (cond
          ((looking-at-p block-re)
            (when (< content-line-count 2)
              (delete-region start-pos (1+ (point-at-bol))))
            (setq start-pos (point))
            (forward-line)
            (setq content-line-count (if (looking-at-p blank-line-re) 0 1)))
          ((not (looking-at-p blank-line-re))
            (setq content-line-count (1+ content-line-count)))))
      (when (< content-line-count 2)
        (delete-region start-pos (point-max)))
      (goto-char (point-min))
      ;; The above strategy can leave a separator line at the beginning
      ;; of the buffer.
      (when (looking-at-p block-re)
        (delete-region (point) (1+ (point-at-eol))))))
  (setq buffer-read-only t)
  )
;; (add-hook 'org-agenda-finalize-hook #'org-agenda-delete-empty-blocks)

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
  (org-agenda nil "g")
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

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
        (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))
