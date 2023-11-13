(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(org-agenda-files
   '("/home/jan/org/todo.org" "/home/jan/org/notes.org" "/home/jan/org/journal.org" "/home/jan/org/agenda.org"))
 '(package-selected-packages
   '(origami zig-mode xcscope which-key use-package org-journal org-bullets nerd-icons magit lsp-ui lsp-treemacs lsp-pyright helm-xref helm-lsp gruvbox-theme flycheck company-box auctex all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq user-full-name "Jan Tomassi")

(setq frame-resize-pixelwise t)

;; (setq scroll-margin 1
;;       scroll-conservatively 0
;;       scroll-up-aggressively 0.01
;;       scroll-down-aggressively 0.01)
;; (setq-default scroll-up-aggressively 0.01
;;       scroll-down-aggressively 0.01)

(tool-bar-mode 0) ;; Disable the tool bar at the top
(menu-bar-mode 0) ;; Disable the menu bat at the top
(scroll-bar-mode -1) ;; Disabel lateral scroll bar for all windows

;; Setup package repository
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(require 'use-package)

;; Auto update packages every time the emacs server is started
;; (use-package auto-package-update :ensure t
;;   :config
;;   (package-refresh-contents :async)
;;   (auto-package-update-now-async))

;; Add Icons support
(use-package all-the-icons :ensure t
  :if (display-graphic-p))
;; Add support for nerd font icons
(use-package nerd-icons :ensure t
  :if (display-graphic-p))

;; Git tools in emacs
(use-package magit :ensure t)

;; Incremental completion for many emacs mode
(use-package helm :ensure t
  :config
  (helm-mode)

  ;; Support for emacs xref in helm searching mode
  (use-package helm-xref :ensure t
    :config
    (require 'helm-xref)
    (define-key global-map [remap find-file] #'helm-find-files)
    (define-key global-map [remap execute-extended-command] #'helm-M-x)
    (define-key global-map [remap switch-to-buffer] #'helm-mini)))

;; Helper for navigating window
(use-package ace-window :ensure t
  :bind
  ("M-o" . ace-window))

;; Org mode stuff
(use-package org :ensure t
  :config
  (setq org-agenda-files '("/home/jan/org/"))
  (use-package org-bullets :ensure t
    :config
    (require 'org-bullets)
    :hook
    (org-mode-hook . (lambda () (org-bullets-mode 1))))
  
  (use-package org-journal :ensure t
    :config
    (require 'org-journal)
    (setq org-journal-dir "/home/jan/org/journal")))

;; Suggest possible completion of the currently entered command
(use-package which-key :ensure t
  :config
  (require 'which-key)
  (which-key-mode)
  (which-key-setup-side-window-bottom))

;; Package for theme development 
;;(use-package fontify-face :ensure t)

;; My favorite theme
(use-package gruvbox-theme :ensure t
  :config
  (load-theme 'gruvbox-dark-hard))

;; Folding functionality for many language
;; https://github.com/gregsexton/origami.el
(use-package origami :ensure t
  :hook
  (c-mode . origami-mode)
  (c++-mode . origami-mode)
  :bind
  (:map origami-mode-map
	("C-' c" . origami-close-node)
	("C-' o" . origami-open-node)))

;; Commplition suggestion in a small windows under the cursor
(use-package company :ensure t
  :bind
  ("M-/" . company-complete)
  (:map company-active-map
	("<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  :hook
  (prog-mode . company-mode))

;; Add to company default window icons and color
(use-package company-box :ensure t
  :hook
  (company-mode . company-box-mode))

(use-package lsp-mode :ensure t
  :init
  (setq lsp-keymap-prefix "C-S-l")
  :custom
  (gc-cons-threshold (* 100 1024 1024))
  (read-process-output-max (* 1024 1024))
  (treemacs-space-between-root-nodes nil)
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  (lsp-idle-delay 0.1)
  (lsp-on-type-formatting nil)
  :hook
  (lsp-mode-hook . lsp-enable-which-key-integration)
  (lsp-mode-hook . lsp-enable-xref)
  (typescript-mode-hook . lsp-deferred)
  (javascript-mode-hook . lsp-deferred)
  (rust-mode . lsp-deferred)
  (c++-mode . lsp-deferred)
  (c-mode . lsp-deferred)
  :commands
  (lsp lsp-deferred))

;; Add many usefull ui view for lsp
(use-package lsp-ui :ensure t
  :commands lsp-ui-mode)
(use-package lsp-treemacs :ensure t)
;; Support helm style searching for the lsp funcitonality
(use-package helm-lsp :ensure t
  :commands helm-lsp-workspace-symbol)


;; Python language servers
;; (use-package lsp-jedi :ensure t)
;; (setq lsp-jedi-workspace-extra-paths
;; 	 ["/home/jan/src/my-project/.venv/lib/python3.10/site-packages"])
(use-package lsp-pyright :ensure t
  :after lsp-mode)

(use-package flycheck :ensure t)

;; latex major mode
(use-package tex :ensure auctex)

;; zig mode
(use-package zig-mode :ensure t
  :hook
  (zig-mode . (lambda () "prevent the exec of company" (company-mode -1))
  ))

(use-package cmake-mode :ensure t)

;; Fast writing of htlm files
(use-package emmet-mode :ensure t)


;; Enable the indicator at the bottom for the column number
(setq column-number-mode t)
;; Hook on the proggramming hook that run on every mode that defived from it
;; this enable the left column to show the row number
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; (setq make-backup-files nil) ; stop creating backup~ files
;; (setq auto-save-default nil) ; stop creating #autosave# files

;; Save the backup~ files in a directory in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
;; Save the #autosave# files in a directory in /tmp
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory)))

;; Don't show the default emacs splash screen
(setq inhibit-splash-screen t)
;; Row numbers are shown as absolute
(setq display-line-numbers 'absolute)
;; Set default font size
(set-face-attribute 'default nil :height 100)
;; Set font
(set-frame-font "FiraMono Nerd Font 11" nil t)
;; (setq default-frame-alist '((font . "FiraCode Nerd Font 11")))

;; always live some line at the bottom and at the top 
(setq scroll-margin 3)
;; two line at a time
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)))
;; don't accelerate scrolling
(setq mouse-wheel-progressive-speed nil)
;; scroll window under mouse
(setq mouse-wheel-follow-mouse 't)
;; keyboard scroll one line at a time
(setq scroll-step 1)




;; Start keybinding sections
(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down-line 2)))
