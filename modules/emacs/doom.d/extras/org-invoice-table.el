;;; org-invoice-table.el --- Invoicing table formatter for org-mode.
;;; -*- lexical-binding: t -*-
;;
;; Copyright (C) 2022 Trevor Richards
;;
;; Author: Trevor Richards <trev@trevdev.ca>
;; Maintainer: Trevor Richards <trev@trevdev.ca>
;; URL: https://git.sr.ht/~trevdev/org-invoice-table
;; Created: 7nd September, 2022
;; Version: 0.1.0
;; License: GPL3
;; Package-Requires: (org)
;;
;; This file is not a part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.
;;
;; See the GNU General Public License for more details. You should have received
;; a copy of the GNU General Public License along with this program. If not, see
;; <https://www.gnu.org/licenses/>.
;;
;;; Commentary:
;; This package adds a table formatter for calculating invoices for project
;; based todo items. You may use it with the `:formatter' keyword in the
;; #+BEGIN: clocktable option.
;;
;; The formatter will also generate columns for effort estimates & comments if
;; they are specified and applicable. Use the `:properties' keyword and provide
;; a list containing property you would like as a column. For example:
;; :properties ("Effort" "Comments").
;;
;; You may also override the billable rate for the table with the `:rate'
;; property.
;;
;;; Code:

(defgroup org-invoice-table nil
  "Customize the org-invoice-table."
  :group 'org-clocktable)

(defcustom org-invoice-table-rate 90
  "The default billable rate for generating the invoice table."
  :type 'integer
  :group 'org-invoice-table)

(defun org-invoice-table-indent (level)
  "Create an indent based on org `LEVEL'."
  (if (= level 1) ""
    (concat (make-string (1- level) ?—) " ")))

(defun org-invoice-table-get-prop (key props)
  "Retrieve the assoc value of some `PROPS' using a `KEY'."
  (cdr (assoc key props)))

(defun org-invoice-table-price (minutes &optional rate)
  "Get the cost of `MINUTES' spent on a project.
Optionally accepts a `RATE' but defaults to `org-invoice-table-rate'."
  (let* ((hours (/ (round (* (/ minutes 60.0) 100)) 100.0))
         (amount (* hours (cond ((numberp rate) rate)
                                ((numberp org-invoice-table-rate)
                                 org-invoice-table-rate)

                                (0))))
         (billable (/ (round (* amount 100)) 100.0)))
    billable))

(defun org-invoice-emph (string &optional emph)
  "Emphasize a `STRING' if `EMPH' is non-nil."
  (if emph
      (format "*%s*" string)
    string))

(declare-function org-clock--translate "org-clock.el")
(declare-function org-time-stamp-format "org.el")
(declare-function org-clock-special-range "org-clock.el")
(declare-function org-duration-from-minutes "org-duration.el")
(declare-function org-duration-to-minutes "org-duration.el")
(declare-function org-table-align "org-table.el")
(declare-function org-table-recalculate "org-table.el")
(defvar org-duration-format) ; org-duration.el
(declare-function org-ctrl-c-ctrl-c "org.el")

;;;###autoload
(defun org-invoice-table (ipos tables params)
  "Generate an invoicing clocktable with the given `IPOS', `TABLES' and `PARAMS'.
The `IPOS' is the point position. `TABLES' should be a list of table data.
The `PARAMS' should be a property list of table keywords and values.

See `org-clocktable-write-default' if you want an example of how the standard
clocktable works."
  (let* ((lang (or (plist-get params :lang) "en"))
         (block (plist-get params :block))
         (emph (plist-get params :emphasize))
         (header (plist-get params :header))
         (properties (or (plist-get params :properties) '()))
         (comments-on (member "Comment" properties))
         (formula (plist-get params :formula))
         (rate (plist-get params :rate))
         (has-formula (cond ((and formula (stringp formula))
                             t)
                            (formula (user-error "Invalid :formula param"))))
         (effort-on (member "Effort" properties)))
    (goto-char ipos)

    (insert-before-markers
     (or header
         ;; Format the standard header.
         (format "#+CAPTION: %s %s%s\n"
                 (org-clock--translate "Clock summary at" lang)
                 (format-time-string (org-time-stamp-format t t))
                 (if block
                     (let ((range-text
                            (nth 2 (org-clock-special-range
                                    block nil t
                                    (plist-get params :wstart)
                                    (plist-get params :mstart)))))
                       (format ", for %s." range-text))
                   "")))
     "| Task " (if effort-on "| Est" "")
     "| Time | Billable"
     (if comments-on "| Comment" "") "\n")
    (let '(total-time (apply #'+ (mapcar #'cadr tables)))
      (when (and total-time (> total-time 0))
        (pcase-dolist (`(, file-name , file-time , entries) tables)
          (when (and file-time (> file-time 0))
            (pcase-dolist (`(,level ,headline ,tgs ,ts ,time ,props) entries)
              (insert-before-markers
               (if (= level 1) "|-\n|" "|")
               (org-invoice-table-indent level)
               (concat (org-invoice-emph headline (and emph (= level 1))) "|")
               (if-let (effort (org-invoice-table-get-prop "Effort" props))
                 (concat (org-invoice-emph
                          (org-duration-from-minutes
                           (org-duration-to-minutes effort))
                          (and emph (= level 1)))
                         "|")
                 "")
               (concat (org-invoice-emph
                        (org-duration-from-minutes time)
                        (and emph (= level 1)))
                       "|")
               (concat (org-invoice-emph
                        (format "$%.2f" (org-invoice-table-price time rate))
                        (and emph (= level 1)))
                       "|")
               (if-let* (comments-on
                         (comment
                          (org-invoice-table-get-prop "Comment" props)))
                   (concat comment "\n")
                 "\n")))))
        (let ((cols-adjust
               (if (member "Effort" properties)
                   2
                 1)))
          (insert-before-markers
           (concat "|-\n| "
                   (org-invoice-emph "Totals" emph)
                   (make-string cols-adjust ?|))
           (concat (org-invoice-emph
                    (format "%s" (org-duration-from-minutes total-time)) emph)
                   "|")
           (concat (org-invoice-emph
                    (format "$%.2f" (org-invoice-table-price total-time rate))
                    emph) "|" ))
          (when has-formula
            (insert "\n#+TBLFM: " formula)))))
    (goto-char ipos)
    (skip-chars-forward "^|")
    (org-table-align)
    (when has-formula (org-table-recalculate 'all))))

;;;###autoload
(defun org-invoice-table-toggle-duration-format ()
  "Toggle the `org-duration-format' from fractional hours to hours/minutes."
  (interactive)
  (if (equal org-duration-format '((special . h:mm)))
      (setq-local org-duration-format '(("h" . nil) (special . 2)))
    (setq-local org-duration-format '((special . h:mm))))
  (org-ctrl-c-ctrl-c))

(provide 'org-invoice-table)

;;; org-invoice-table.el ends here
