;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Quinn Dougherty"
      user-mail-address "quinnd@riseup.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "monospace" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 18))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq rand-theme-wanted '(doom-outrun-electric doom-acario-dark doom-manegarm manoj-dark))
(rand-theme)

; other defaults for startup.
(minimap-mode)
(add-hook 'window-setup-hook #'treemacs t)
;; gcal sync on boot will be like ~add-hook~
(setq doom-themes-treemacs-enable-variable-pitch nil)

(setq projectile-project-search-path '("~/projects") projectile-sort-order 'recentf)

(setq vterm-eval-cmds '(("find-file" find-file)
                        ("message" message)
                        ("vterm-clear-scrollback" vterm-clear-scrollback)
                        ("dired" dired)
                        ("ediff-files" ediff-files)))
; (custom-set-variables explicit-shell-file-name "/run/current-system/sw/bin/fish")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(load! "./extras/org-download-clipboard-pdf.el")
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-modern-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))
;; (map! :after org :map org-mode-map :prefix "SPC m d" "p" #'org-download-clipboard-pdf)
(map! :after org :map org-mode-map :prefix "C-c d" "p" #'org-download-clipboard-pdf)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   ; (julia . t)
   (python . t)
   (jupyter . t)))
(setq org-modern-label-border nil)
(global-org-modern-mode)

(setq org-agenda-files '("health.org" "beaur.org" "profesh" "profesh/casper"))

(add-hook 'elfeed-search-mode-hook #'elfeed-update)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(add-hook `pdf-view-mode-hook `pdf-view-themed-minor-mode)

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

;; coq, proof general
(custom-set-variables '(proof-three-window-enable t))
(custom-set-variables
 `(coq-prog-name "coqtop")
 )
;; `+company-init-backends-h' in `after-change-major-mode-hook' overrides
;; `company-backends' set by `company-coq' package. This dirty hack fixes
;; completion in coq-mode. TODO: remove when company backends builder is
;; reworked.
(defvar-local +coq--company-backends nil)
(after! company-coq
  (defun +coq--record-company-backends-h ()
    (setq +coq--company-backends company-backends))
  (defun +coq--replay-company-backends-h ()
    (setq company-backends +coq--company-backends))
  (add-hook! 'company-coq-mode-hook
    (defun +coq--fix-company-coq-hack-h ()
      (add-hook! 'after-change-major-mode-hook :local #'+coq--record-company-backends-h)
      (add-hook! 'after-change-major-mode-hook :append :local #'+coq--replay-company-backends-h))))
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (push '(coq-mode . "coq") lsp-language-id-configuration)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "coq-lsp")
                    :activation-fn (lsp-activate-on "coq")
                    :server-id 'coq-lsp))
  :commands lsp)

(after! rescript-mode
	(setq lsp-rescript-server-command
	      '("node" "/home/qd/Dropbox/dotfiles/framework/users/qd/rescript-vscode/server/out/server.js" "--stdio"))
	;; Tell `lsp-mode` about the `rescript-vscode` LSP server
	(require 'lsp-rescript)
	;; Enable `lsp-mode` in rescript-mode buffers
	(add-hook 'rescript-mode-hook 'lsp-deferred)
	;; Enable display of type information in rescript-mode buffers
	(require 'lsp-ui)
	(add-hook 'rescript-mode-hook 'lsp-ui-doc-mode))

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "stylish-haskell"))
(set-formatter! 'stylish-haskell "stylish-haskell" :modes '(haskell-mode ".hs"))

(setq auth-sources '("~/.authinfo.gpg"))

(setq gpt-openai-key "")
(setq gpt-openai-engine "gpt-4")
;; (setq gpt-openai-use-chat-api t)
;; (setq gpt-openai-org "org-5p...Y")  ;; NOT SET
(setq gpt-openai-max-tokens 2000)
(setq gpt-openai-temperature 0)

(envrc-global-mode)
(direnv-mode)
;; auto-load agda-mode for .agda and .lagda.md
;; (setq auto-mode-alist
;;   (append
;;     '(("\\.agda\\'" . agda2-mode)
;;       ("\\.lagda.md\\'" . agda2-mode))
;;     auto-mode-alist))
;; (load-file (let ((coding-system-for-read 'utf-8))
;;                 (shell-command-to-string "agda-mode locate")))

;;
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
