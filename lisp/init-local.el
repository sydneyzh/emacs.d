;;; init-local.el --- Local settings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;;; evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;;; jinja2-mode
(use-package jinja2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . jinja2-mode))
  (superword-mode)
  )

;;; neotree
(use-package neotree
  :config
  (global-set-key [f8] 'neotree-toggle))

(provide 'init-local)
;;; init-local.el ends here

