;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Suhao Jeffrey Huang"
      user-mail-address "sjhuang26@gmail.com")

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
      ;;doom-font (font-spec :family "JetBrainsMono" :size 15 :weight 'normal)
      doom-font (font-spec :family "Go Mono" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Source Serif Pro" :size 18 :weight 'normal))
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


;; Theming
(setq modus-themes-bold-constructs t)
(setq modus-themes-italic-constructs t)
(setq modus-themes-syntax '(faint alt-syntax))
(setq modus-themes-mode-line '((padding 4) accented borderless))
(setq modus-themes-completions
      '((matches . (extrabold intense))
        (selection . (extrabold intense))
        (popup . (extrabold intense))))
;; (set-face-attribute 'mode-line nil :underline nil)


;; Font utilities
(defun fix-line-numbers ()
  (interactive)
  (set-face-font 'line-number doom-font))
;; Define my own modes
(define-minor-mode review-mode "Review mode")
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
  (setq indent-tabs-mode t)
  (setq font-lock-defaults '(review-text-highlights)))

;; Functions for review-mode
(defun review-mode-hide-lines ()
  "Helper for review mode that hides lines."
  ;; https://stackoverflow.com/questions/23677844/emacs-how-to-show-only-the-lines-on-or-before-the-cursor-in-a-file
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

;; Transient mode for review-mode
(use-package! transient
  :config
  ;; aka. define-transient-command
  (transient-define-prefix review-mode-begin-display ()
    "Review Mode Display"
    :transient-suffix 'transient--do-stay
    :transient-non-suffix 'transient--do-stay
    ["Actions"
     ("5" "Show until next line" review-mode-hide-lines) ;; :transient t)
     ("8" "Show until next asterisk" review-mode-show-to-asterisk)]) ;; :transient t)
     
  (map! :leader :mode review-mode :desc "begin review display" :n "r" #'review-mode-begin-display))
  

;; General configuration
(setq evil-escape-key-sequence "fd")
(setq +lookup-provider-url-alist
      (append +lookup-provider-url-alist '(
                                           ("Bible Gateway" "https://www.biblegateway.com/passage/?search=%s&version=CSB")
                                           ("Genius" "https://genius.com/search?q=%s"))))
(setq +workspaces-on-switch-project-behavior nil)
(setq org-cycle-include-plain-lists 'integrate)

;(spacemacs/declare-prefix-for-minor-mode 'review-mode "r" "review mode")
;;(spacemacs/set-leader-keys-for-minor-mode 'review-mode "." 'spacemacs/review-mode-transient-state/body)

;; Declare all hooks and maps
(add-hook! org-mode #'mixed-pitch-mode #'review-mode #'org-autolist-mode)
(add-hook! review-text-mode #'mixed-pitch-mode)
(add-hook! typescript-tsx-mode #'variable-pitch-mode #'fix-line-numbers)
(add-hook! typescript-mode #'variable-pitch-mode #'fix-line-numbers)
(add-hook! markdown-mode #'variable-pitch-mode #'fix-line-numbers)
(map! :map transient-map "?" nil)
;; (map! :leader :mode review-text-mode :desc "insert TAB" :n "TAB" #'tab-to-tab-stop)
(map! :leader :desc "review text mode" :n "R" #'review-text-mode)
;; (map! :leader :desc "Insert TAB" "`" #'tab-to-tab-stop)
;; (map! :leader :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer)
(setq typescript-indent-level 2)

;; test
;; (setq popup-use-optimized-column-computation nil)

;; Copy and paste
(map! :leader :map doom-leader-workspace-map :n "TAB")
