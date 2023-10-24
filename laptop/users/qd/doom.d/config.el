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
(setq doom-font (font-spec :family "iosevka" :size 13 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 15))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq rand-theme-wanted '(doom-outrun-electric doom-acario-dark doom-manegarm manoj-dark))
(rand-theme)

; other defaults for startup.
(minimap-mode)
(add-hook 'window-setup-hook #'treemacs t)

(setq projectile-project-search-path '("~/Dropbox/Projects/") projectile-sort-order 'recentf)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Org/")

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

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))
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
