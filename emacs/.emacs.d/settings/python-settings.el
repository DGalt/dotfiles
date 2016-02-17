;;; python-settings.el --- Summary
;;;
;;; Commentary:
;;;
;;; Code:
;(require 'python)
(pyenv-mode)
;;enable anaconda-mode and eldoc-mode in all python and EIN buffers
;;(add-hook 'python-mode-hook 'anaconda-mode)
;;(add-hook 'ein:notebook-multilang-mode-hook 'anaconda-mode)
;;(add-hook 'python-mode-hook 'eldoc-mode)
;(add-hook 'python-mode-hook #'(lambda ()
                              ; (add-to-list 'company-backends 'company-anaconda)))

;;enable jedi-mode for autocompletion
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot nil)
;(defun my/python-mode-hook ()
 ; (add-to-list 'company-backends 'company-jedi))

;(add-hook 'python-mode-hook 'my/python-mode-hook)
;;use IPython
(setq python-shell-interpreter "python")
(setq python-shell-interpreter-args "-m IPython")


;;Emacs IPython Notebook (EIN)
(require 'ein)

(provide 'python-settings)
;;; python-settings.el ends here


