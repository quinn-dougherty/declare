;;; org-download-pdf.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Quinn Dougherty
;;
;; Author: Quinn Dougherty <quinnd@riseup.net>
;; Maintainer: Quinn Dougherty <quinnd@riseup.net>
;; Created: October 26, 2023
;; Modified: October 26, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/qd/org-download-pdf
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
(require 'org-download)
(require 'url)

(defun org-download-get-clipboard-url ()
  "Retrieve the URL from the clipboard."
  (substring-no-properties (current-kill 0)))

(defun org-download-ensure-pdf-extension (filename default-name)
  "Ensure that FILENAME ends with '.pdf'. If FILENAME is empty, return DEFAULT-NAME."
  (cond
   ((string-empty-p filename) default-name)
   ((string-suffix-p ".pdf" filename) filename)
   (t (concat filename ".pdf"))))

(defun org-download-prompt-filename (default-name)
  "Prompt the user for a filename using the `read-file-name` interface with `ivy`.
Default to DEFAULT-NAME if no name is provided. Ensure the name ends with '.pdf'."
  (let ((ivy-count-format "") ; Hide the count format in the minibuffer
        (chosen-name (read-file-name (format "Save PDF as (default %s): " default-name)
                                     default-directory
                                     nil
                                     nil
                                     nil)))
    (org-download-ensure-pdf-extension chosen-name default-name)))

(defun org-download-verify-pdf-url (url)
  "Verify that the URL points to a PDF. Error out if not."
  (let ((response (url-retrieve-synchronously url t)))
    (unless (string-match-p "Content-Type: application/pdf" (with-current-buffer response (buffer-string)))
      (error "The link doesn't point to a valid PDF"))))

(defun org-download-clipboard-pdf ()
  "Downloads the PDF linked in the clipboard and prompts for the filename."
  (interactive)

  (let* ((url (org-download-get-clipboard-url))
         (default-filename (concat (file-name-nondirectory url) ".pdf"))
         (chosen-filename (org-download-prompt-filename default-filename))
         (fullpath chosen-filename))

    (unless (string-match-p "\\.pdf$" url)
      (error "The clipboard content doesn't seem to be a PDF link"))

    (org-download-verify-pdf-url url)

    (url-copy-file url fullpath t)
    (message "PDF downloaded to %s" fullpath)))

(provide 'org-download-clipboard-pdf)
;;; org-download-pdf.el ends here
