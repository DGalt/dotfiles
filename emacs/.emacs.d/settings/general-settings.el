;;; general-settings.el --- Summary
;;;
;;; Commentary:
;;;
;;; Code:

;;;
;;path to theme files
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'chiaro t)

;;set default font
(set-frame-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 105)

;;hide toolbar 
(tool-bar-mode -1)

;;hide menu-bar
(menu-bar-mode -1)

;;hide scrollbar
(scroll-bar-mode -1)

;;highlight matching pairs (braces, etc), with delay removed
(setq show-paren-delay 0)
(show-paren-mode 1)

;;highlight current line
(global-hl-line-mode 1)

;;volatile highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;;ztree
(require 'ztree-diff)
(require 'ztree-dir)

(provide 'general-settings)
;;; general-settings ends here


