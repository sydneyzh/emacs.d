;;; init-local.el --- Local settings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;;; auto-complete
(use-package auto-complete
  :ensure t)

;;; evil
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (cl-loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
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
                                   (magit-mode . emacs)
                                   (magit-branch-manager-mode . emacs)
                                   (rdictcc-buffer-mode . emacs)
                                   (dired-mode . emacs)
                                   (wdired-mode . normal)
                                   (xref--xref-buffer-mode . emacs))
           do (evil-set-initial-state mode state))
  )

;; undo-tree
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :after evil
  :config
  (global-undo-tree-mode)
  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
  (define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)
  )

;;; popwin
(use-package popwin
  :ensure t
  :diminish popwin-mode
  :config
  ;; config "popwin:special-display-config"
  (push '("*Anaconda*" :dedicated t :position right :stick t :noselect t :width 0.3) popwin:special-display-config)
  (push '("*Autocomplete Error*" :dedicated t :position bottom :stick t :noselect t :height 0.2) popwin:special-display-config)
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
  )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; jinja2-mode
(use-package jinja2-mode
  :ensure t
  :mode ("\\.html?\\'" . jinja2-mode)
  :config
  (superword-mode)
  )

;;; neotree
(use-package neotree
  :ensure t
  :init
  (global-set-key [f8] 'neotree-toggle))

;;; winum
(use-package winum
  :ensure t
  :init
  (winum-set-keymap-prefix (kbd "C-c"))
  (winum-mode)
  )

;;; customize switch-window-shortcut-style
(when (maybe-require-package 'switch-window)
  (setq switch-window-shortcut-style 'quaill))

;;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (when (boundp '*snippet-dir*)
    (setq yas-snippet-dirs '(*snippet-dir*)))
  (yas-global-mode 1))

;;; python
(use-package pyenv-mode
  :ensure t
  :hook python-mode)
(use-package pyenv-mode-auto
  :ensure t
  :after pyenv-mode)
(when (maybe-require-package 'flycheck)
  (setq flycheck-python-pycompile-executable "python")) ;; override default "python3"

;;; web-mode
(use-package web-mode
  :ensure t
  :after flycheck
  :mode "\\.tsx\\'"
  :init
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (tide-setup))))
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode))

;;; tide
(use-package tide
  :ensure t
  :init
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    )
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  )


;;; org mode
(with-eval-after-load 'org
  (setq org-confirm-babel-evaluate nil))

;;; reset comment-line key
(global-unset-key (kbd "C-x ;"))
(global-set-key (kbd "C-x ;") 'comment-line)

;;; lisp
(when (boundp '*inferior-lisp-program*)
  (setq inferior-lisp-program *inferior-lisp-program*))

;;; use ibuffer-projectile to filter ibuffer
(when (maybe-require-package 'ibuffer-projectile)
  (add-hook 'ibuffer-hook
            (ibuffer-projectile-set-filter-groups)))

;;; customize selectrum
(when (maybe-require-package 'selectrum)
  (setq selectrum-count-style nil))

;;; customize company
(when (maybe-require-package 'company)
  ;; make plain text case sensitive
  (setq company-dabbrev-downcase nil))

;;; workgroups2 mode
;;; preserve window layout when using emacs daemon
(use-package workgroups2
  :ensure t
  :init
  (workgroups-mode t))

(provide 'init-local)
;;; init-local.el ends here
