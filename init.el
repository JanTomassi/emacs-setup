(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7"))
 '(package-selected-packages
   '(magit htmlize company-box company gruvbox-theme gruvbox rainbow-mode kurecolor tree-sitter-langs tree-sitter-lang tree-sitter lsp-mode yasnippet which-key helm use-package autothemer)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'org)
(org-babel-load-file "~/.emacs.d/personal/init.org")
