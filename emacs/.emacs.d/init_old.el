;;; .emad.d/init.el --- Summary
;;;
;;; Commentary:

;;; Code:
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'chiaro t)

;;set default font
(set-frame-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 105)

;;hide toolbar 
(tool-bar-mode -1)

;;hide scrollbar
(scroll-bar-mode -1)

;;highlight matching pairs (braces, etc), with delay removed
(setq show-paren-delay 0)
(show-paren-mode 1)

;;highlight current line
(global-hl-line-mode 1)

;;enable anaconda-mode and eldoc-mode in all python buffers
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

;;enable company mode globally and add company-anaconda backend
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-anaconda))

;;makes completion start automatically rather than waiting for 3 chars / 0.5sec
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)

;;company quickhelp gives docstring info
(company-quickhelp-mode 1)

;;enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;enable fill-column-indicator for 80char line indication
(require 'fill-column-indicator)
(add-hook 'prog-mode-hook 'fci-mode)
(setq fci-rule-column 80)


;;workaround for bug between company mode and fill-column-indicator
(defvar-local company-fci-mode-on-p nil)

(defun company-turn-off-fci (&rest ignore)
  (when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))

(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))

(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)
