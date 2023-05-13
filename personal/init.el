(setq user-full-name "Jan Tomassi")

(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(use-package magit :ensure t)

(use-package autothemer :ensure t)

(use-package helm :ensure t)
(helm-mode)

(use-package helm-xref :ensure t)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(use-package htmlize :ensure t)

(use-package kurecolor :ensure t)

(use-package tree-sitter :ensure t)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package tree-sitter-langs :ensure t)

(use-package which-key :ensure t)

(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

(use-package yasnippet :ensure t)

(require 'yasnippet)
(yas-global-mode 1)

(use-package fontify-face :ensure t)

(use-package gruvbox-theme :ensure t)

(use-package company :ensure t
  :bind
  (:map company-active-map
	("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  :hook
  (prog-mode . company-mode))

(use-package company-box :ensure t
  :hook
  (company-mode . company-box-mode))

(use-package lsp-mode :ensure t)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (yas-global-mode))

(load-theme 'gruvbox-dark-hard)

(setq inhibit-splash-screen t)
(setq column-number-mode t
      display-line-numbers 'absolute)
