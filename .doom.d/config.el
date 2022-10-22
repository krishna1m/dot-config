;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Manmohan Krishna"
      user-mail-address "krishna.m.zyw@gmail.com")

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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default: `doom-one'
(setq doom-theme
      'doom-gruvbox
      ;; 'doom-opera
      )


(setq doom-font (font-spec :family "Ubuntu Mono" :size 14)
     doom-big-font (font-spec :family "Ubuntu Mono" :size 20)
     doom-variable-pitch-font (font-spec :family "Ubuntu Mono" :size 14)
     doom-unicode-font (font-spec :family "Ubuntu Mono")
     doom-serif-font (font-spec :family "Ubuntu Mono" :weight 'light))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (setq org-directory "~/org/")
  (setq org-log-done 'note))

;; Deft configuration
(setq deft-directory "~/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; Which-key delay seconds
(setq which-key-idle-delay 0)

(setq treemacs-position 'right)

;; Centaur-tabs
(centaur-tabs-mode t)
(centaur-tabs-headline-match)
(setq centaur-tabs-set-icons t
      centaur-tabs-set-bar 'left
      centaur-tabs-set-close-button nil
      centaur-tabs-set-modified-marker t)

;; Load up banner
(setq +doom-dashboard-banner-file (expand-file-name "resized_200.png" doom-private-dir))

;; https://scalameta.org/metals/docs/editors/emacs/
;; Note that if you try to do that from sbt-mode, you may get an error unless you patch lsp-find-workspace with the following:
(defun lsp-find-workspace (server-id &optional file-name)
    "Find workspace for SERVER-ID for FILE-NAME."
    (-when-let* ((session (lsp-session))
                 (folder->servers (lsp-session-folder->servers session))
                 (workspaces (if file-name
                                 (let* ((folder (lsp-find-session-folder session file-name))
                                        (folder-last-char (substring folder (- (length folder) 1) (length folder)))
                                        (key (if (string= folder-last-char "/") (substring folder 0 (- (length folder) 1)) folder)))
                                   (gethash key folder->servers))
                               (lsp--session-workspaces session))))

      (--first (eq (lsp--client-server-id (lsp--workspace-client it)) server-id) workspaces)))

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

