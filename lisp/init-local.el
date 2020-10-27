;;; init-local.el --- Local settings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;; evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (help-mode . emacs)
                              (helm-grep-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (wdired-mode . normal)
                              (xref--xref-buffer-mode . emacs))
      do (evil-set-initial-state mode state))

;;; popwin
(use-package popwin
  :diminish popwin-mode
  :config
  ;; config "popwin:special-display-config"
  (push '("*Anaconda*" :dedicated t :position right :stick t :noselect t :width 0.3) popwin:special-display-config)
  (push '("*Autocomplete Error*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config))
  (push '("*Autocomplete Output*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config)
  (push '("*Backtrace*" :dedicated t :position right :stick t :noselect t :width 0.5) popwin:special-display-config)
  (push '("*Flycheck error messages*" :dedicated t :position right :stick t :noselect t :height 0.1) popwin:special-display-config)
  (push '("*Help*" :dedicated t :position bottom :stick t :noselect t :height 0.5) popwin:special-display-config)
  (push '("*Messages*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config)
  (push '("*Shell Command Error*" :dedicated t :position bottom :stick t :noselect t :height 0.1) popwin:special-display-config)
  (push '("*Shell Command Output*" :dedicated t :position bottom :stick t :noselect t :height 0.1) popwin:special-display-config)
  (push '("*Warnings*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config)
  (push '("*xref*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config)
(popwin-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; jinja2-mode
(use-package jinja2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . jinja2-mode))
  (superword-mode)
  )

;;; neotree
(use-package neotree
  :config
  (global-set-key [f8] 'neotree-toggle))

;;; winum
(use-package winum
  :config
  (winum-set-keymap-prefix (kbd "C-c")))
(winum-mode)

;;; yasnippet
(use-package yasnippet
  :config
  (when (boundp '*snippet-dir*)
    (setq yas-snippet-dirs '(*snippet-dir*))))
(yas-global-mode 1)

;;; python
(use-package pyenv-mode
  :hook python-mode)
(use-package pyenv-mode-auto
             :after pyenv-mode)
(when (maybe-require-package 'flycheck)
  (setq flycheck-python-pycompile-executable "python")) ;; override default "python3"

(provide 'init-local)
;;; init-local.el ends here
