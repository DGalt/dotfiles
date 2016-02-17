;;; general-code-settings.el --- Summary
;;;
;;; Commentary:
;;;
;;; Code:

;;enable company mode globally and add company-anaconda backend
(add-hook 'after-init-hook 'global-company-mode)
;;(with-eval-after-load 'company
  ;;  (add-to-list 'company-backends 'company-anaconda))

;;makes completion start automatically rather than waiting for 3 chars / 0.5sec
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)

;;company quickhelp gives docstring info
(company-quickhelp-mode 1)
(setq company-quickhelp-max-lines 8)

;;enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;enable flycheck tooltip
(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)

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

;; yasnippet
(require 'yasnippet)
(yas-global-mode t)

;;
(require 'ycmd)
(add-hook 'after-init-hook #'global-ycmd-mode)
(set-variable 'ycmd-server-command '("python2" "/home/dan/.ycmd/ycmd/ycmd"))
(require 'company-ycmd)
(company-ycmd-setup)
(set-variable 'ycmd-enable-fuzzy-matching nil)

(provide 'general-code-settings)
;;; general-code-settings.el ends here

