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

(provide 'init-local)
;;; init-local.el ends here

