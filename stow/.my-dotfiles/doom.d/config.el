;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi
      doom-font (font-spec :family "JetBrainsMono" :size 15 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Mignon" :size 18 :weight 'light))
      ;;(load-theme 'modus-operandi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
(setq evil-escape-key-sequence "fd")
;; https://stackoverflow.com/questions/23677844/emacs-how-to-show-only-the-lines-on-or-before-the-cursor-in-a-file
  (defun review-mode-hide-lines ()
    "Helper for review mode that hides lines."
    (interactive)
    (widen)
    (call-interactively 'move-end-of-line)
    (forward-char)
    (call-interactively 'move-end-of-line)
    (narrow-to-region 1 (point)))

  (defun review-mode-show-to-asterisk ()
    "Show lines until a line beginning with an asterisk is reached."
    (interactive)
    (widen)
    (catch 'loop (while (not (eobp))
                   (forward-line 1)
                   (when (string-match "\*.*" (thing-at-point 'line)) (throw 'loop t))))
    (forward-line 1)
    (narrow-to-region 1 (point)))

;; aka. define-transient-command
(after! transient
(transient-define-prefix review-mode-begin-display ()
  "Review Mode Display"
  :transient-suffix 'transient--do-stay
  :transient-non-suffix 'transient--do-stay
  ["Actions"
   ("5" "Show until next line" review-mode-hide-lines);; :transient t)
   ("8" "Show until next asterisk" review-mode-show-to-asterisk);; :transient t)
   ]))
(define-minor-mode review-mode "Review mode")
(map! :leader :mode review-mode :desc "begin review display" :n "r" #'review-mode-begin-display)

  ;;(spacemacs/declare-prefix-for-minor-mode 'review-mode "r" "review mode")
  ;;(spacemacs/set-leader-keys-for-minor-mode 'review-mode "." 'spacemacs/review-mode-transient-state/body)
(setq review-text-highlights '(
  ("\#.*\n" . 'header-line)
  ("\{.*\}" . 'diff-context)
 ("TODO" . 'diff-error)))

  (define-derived-mode review-text-mode text-mode "review-text"
    "Major mode for editing my review text format."
    ;;(display-line-numbers-mode)
    ;;(setq tab-width 8)
    (local-set-key (kbd "TAB") 'tab-to-tab-stop)
    (review-mode)
    (variable-pitch-mode)
    (setq indent-tabs-mode t)
    (setq font-lock-defaults '(review-text-highlights)))
(map! :leader :mode review-text-mode :desc "insert TAB" :n "TAB" #'tab-to-tab-stop)

(add-hook! org-mode #'variable-pitch-mode #'review-mode)

(after! transient
  (map! :map transient-map "?" nil))
