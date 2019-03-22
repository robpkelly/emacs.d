;;; cloneline.el --- Clone Line (thanks to Kyle Sherman)
;;; Commentary:
;;; shortcut to make a copy of the region, optionally commented.

;;; Code:
(defun clone-line (&optional comment line)
  "Duplicate the line containing the point. If COMMENT is non-nil, also comment out the original line."
  (interactive "P")
  (let ((col (current-column)))
    (save-excursion
      (when line
        (forward-line line))
      (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
        (when comment
          (comment-region (point-at-bol) (point-at-eol)))
        (goto-char (point-at-eol))
        (if (eobp)
            (newline)
          (forward-line 1))
        (open-line 1)
        (insert line)))
    (forward-line 1)
    (move-to-column col)))

(provide 'clone-line)

;;; clone-line.el ends here
