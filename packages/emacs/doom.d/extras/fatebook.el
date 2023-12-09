;;; fatebook.el --- Create predictions on Fatebook  -*- lexical-binding: t;
;;
;; Copyright (C) 2023 Tassilo Neubauer
;;
;; Author: Tassilo Neubauer <tassilo.neubauer@gmail.com>
;; Maintainer: Tassilo Neubauer <tassilo.neubauer@gmail.com>
;; Created: September 07, 2023
;; Modified: September 11, 2023
;; Version: 0.2.1
;; Keywords: calendar comm convenience
;; Homepage: https://github.com/tassilo/fatebook
;; Package-Requires: ((emacs "25.1") (org "4.67"))
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;; TODO: add automated tests
;;; TODO: Make fatebook fail more graciously when the user enters an invalid
;;; dates or predictions by asking for a new input.
;;; TODO: We could add more friendly error messages if api-call fails with http 500 and others.
;;; TODO: In principle would be nice to have a datepicker that doesn't depend on org.
;;;
;;; Code:

(declare-function org-read-date "org-read-date")

(require 'calendar)
(require 'auth-source)
(require 'request)


(defcustom fatebook-api-key-function nil
  "Function to get the API key. If NIL, fatebook--api-key-fn will be used."
  :type 'function
  :group 'fatebook)

(defcustom fatebook-auth-source-backend 'netrc
  "Choose the backend for auth-source.
Options are ``'netrc`` or ``'secrets``."
  :type 'symbol
  :group 'fatebook)

(defcustom fatebook-use-org-read-date t
  "Whether or not to use org-read-date to pick a date."
  :type 'bool
  :group 'fatebook)

(defcustom fatebook-debug nil
  "If non-nil show debug from fatebook api in messages."
  :type 'bool
  :group 'fatebook)

(defun fatebook--pick-date ()
  "Open calendar and return the date selected by the user in 'YYYY-MM-DD' format."
  (if fatebook-use-org-read-date (progn (require 'org)
                                         (org-read-date nil nil nil "Resolve by:"))
        ;FIXME: a simple datepicker that doesn't require org would be nice, but
        ;this turned out more complicated than expected.
        ;I tried writing my own minor mode with it's own keymap, but this
        ;introduced all kinds of complications like it turned out to be hard not to get
        ;RET overwritten by evil. Fixing that without breaking the users keymap was hard.
        ;I sort of expected there already to be a standard function that doesn't
        ;use org to choose the date with the 3-month calendar.
    (seq-let (month day year) (calendar-read-date)
      (calendar-exit)
      (format "%d-%02d-%02d" year month day))))

(defun fatebook--valid-date-p (date)
  "Check if DATE has the format 'YYYY-MM-DD'.
Doesn't exclude all invalid dates. Just here for typos."
  (string-match-p "\\`[0-9]\\{4\\}-[0-1][0-9]-[0-3][0-9]\\'" date))

(defun fatebook-create-question (&optional title resolveBy forecast)
  "Prompt user to create a question and then send it to Fatebook API.
Optional arguments TITLE, RESOLVEBY, and FORECAST can be provided."
  (interactive)
  ;; Load request package only when needed
  (let* ((title (or title (read-string "Question title: ")))
         (resolveBy (or resolveBy (fatebook--pick-date)))
         (forecast (or forecast
                       (/ (read-number "Make a prediction 0-100 (%): ") 100))))

    (unless (fatebook--valid-date-p resolveBy)
      (error "Invalid date format for 'resolveBy'. Expected format: YYYY-MM-DD"))

    (unless (and (>= forecast 0) (<= forecast 1))
      (error "Forecast value must be between 0 and 100. For 40%% write 40"))
    (fatebook--api-call title resolveBy forecast)))

(defun fatebook--api-key-fn ()
  "Retrieve the Fatebook API key from `fatebook-auth-source-backend'."
(let ((credentials (let ((auth-source-creation-prompts '((secret . "Enter API key for %h: "))))
  (auth-source-search :host "fatebook.io"
                      :user "defaultUser"
                      :type fatebook-auth-source-backend
                      ;;:create ;NOTE: auth-source does not support deletion. A
                      ;;convoluted idea that could work is that we
                      ;;just add more and more api keys, and we version them
                      ;;with the :user handle and then just try all of them if
                      ;;none worka. Could lead to complaints from fatebook
                      ;;though.
                      :max 1))))

  (let ((secret (plist-get (car credentials) :secret)))
    (unless secret
      (error "You need to configure an API key for fatebook. See https://github.com/sonofhypnos/fatebook.el#user-content-storing-your-api-keys"))
    secret)))


(defun fatebook--api-call (title resolveBy forecast)
  "API call to fatebook.
TITLE, RESOLVEBY, and FORECAST are required."
  (request
    "https://fatebook.io/api/v0/createQuestion"
    :params `(("apiKey" . ,(if fatebook-api-key-function
                               (funcall fatebook-api-key-function)
                             (funcall (fatebook--api-key-fn))))
              ("title" . ,title)
              ("resolveBy" . ,resolveBy)
              ("forecast" . ,(number-to-string forecast)))
    :success (lambda (&rest response)
               (let ((data (plist-get response :data)))
                 (message "Question created successfully! Visit your question under %S" data)))
    :error (lambda  (&rest response)
             (let ((error-thrown (plist-get response :error-thrown)))
               (message "error-thrown value:%s" error-thrown)
               (when error-thrown
                 (if (and (string-equal (car (cdr error-thrown)) "http")
                          (equal (car (cdr (cdr error-thrown))) 401))
                     (message "Authorization on fatebook.io failed. Please add or update your API key in the file you saved it in. If you've already done this, refresh the cache using: auth-source-forget-all-cached. For further information see: https://github.com/new#user-content-storing-your-api-keys")
                   (message "Unexpected Error from fatebook: %S" error-thrown))
                 (when fatebook-debug
                   (message "More information from fatebook.io: %S" (plist-get response :data))))))))


(provide 'fatebook)
;;; fatebook.el ends here
