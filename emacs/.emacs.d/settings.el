
(setq user-full-name "Daniel Galtieri"
      user-mail-address "daniel.galtieri@gmail.com")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(global-font-lock-mode t)

(global-hl-line-mode 1)

(delete-selection-mode 1)

(setq ring-bell-function (lambda ()))
(setq inhibit-startup-screen t
      initial-major-mode 'fundamental-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

;;Add theme files location
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;Set theme
(load-theme 'chiaro t)

;;Set default font
(set-frame-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 110)

;;Hide toolbar 
(tool-bar-mode -1)

;;Hide menu-bar
(menu-bar-mode -1)

;;Hide scrollbar
(scroll-bar-mode -1)

(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell"))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  ;; just reset dictionary to the safe one "en_US" for hunspell.
  ;; if we need use different dictionary, we specify it in command line arguments
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8))))
 (t (setq ispell-program-name nil)
    (message "You need install either aspell or hunspell for ispell")))

(use-package flyspell
  :defer t
  :diminish flyspell-mode
  :init
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode)
  :config
  ;; better performance
  (setq flyspell-issue-message-flag nil)
  (use-package helm-flyspell
    :init
    (define-key flyspell-mode-map (kbd "M-S") #'helm-flyspell-correct))
  )

;; savehist
(setq savehist-additional-variables
      ;; also save my search entries
      '(search-ring regexp-search-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
(setq-default save-place t)

;; delete-auto-save-files
(setq delete-auto-save-files t)
(setq backup-directory-alist
      '(("." . "~/.emacs_backups")))

;; delete old backups silently
(setq delete-old-versions t)
(setq auto-save-file-name-transforms
      '(("." . "~/.emacs_autosaves")))

;; Enable electric-pair mode (inserts matching delimiters)
(electric-pair-mode 1)
(setq electric-pair-preserve-balance t
      electric-pair-delete-adjacent-pairs t
      electric-pair-open-newline-between-pairs nil)

;; Highlight matching pairs (braces, etc.), with delay removed
(setq show-paren-delay 0)
(show-paren-mode 1)

(use-package org
  :config
  ;;enable syntax highighting in org src blocks
  (setq org-src-fontify-natively t)
  ;;enable native tab behavior in src blocks
  (setq org-src-tab-acts-natively t))

;;enable linum-mode 
(add-hook 'prog-mode-hook 'linum-mode)
;;aggressive indent-mode 
(use-package aggresive-indent
  :config 
  (global-aggressive-indent-mode 1))
;;fill-column-indicator
(use-package fill-column-indicator
  :config
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
  (add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci))

;;company mode
(use-package company
  :config 
  ;;enable company mode globally
  (add-hook 'after-init-hook 'global-company-mode)
  ;;makes completion start automatically rather than waiting for 3 chars / 0.5sec
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0))
;;company quick help - for docstring tooltip
(use-package company-quickhelp
  :config 
  (company-quickhelp-mode 1)
  (setq company-quickhelp-max-lines 8))

(use-package ycmd
  :config
  (add-hook 'after-init-hook #'global-ycmd-mode)
  (set-variable 'ycmd-server-command '("python2" "/home/dan/.ycmd/ycmd/ycmd")))
(use-package company-ycmd
  :config
  (company-ycmd-setup)
  (set-variable 'ycmd-enable-fuzzy-matching nil))

(use-package flycheck
  :defer t
  :diminish flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package pyenv
  :config
  (pyenv-mode))
(use-package ein
  :defer t
  :config
  ;;enable ycmd in ein, not recognized as supported mode by default
  (add-hook 'ein:notebook-multilang-mode-hook 'ycmd-mode)
(setq python-shell-interpreter "python")
(setq python-shell-interpreter-args "-m IPython"))

(use-package magit
  :ensure t)

(use-package helm
  :init
  (require 'helm-config)
  :config
  ;;pretty much all of this config is stolen from Tuhdo's Helm guide
  ;;found: http://tuhdo.github.io/helm-intro.html
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  ;;open helm buffer inside current window, not occupy whole other window
  (setq helm-split-window-in-side-p t)

  ;;move to end or beginning of source when reaching top or bottom of source.
  (setq helm-move-to-line-cycle-in-source t)

  ;;search for library in `require' and `declare-function' sexp.
  (setq helm-ff-search-library-in-sexp t)

  ;;scroll 8 lines other window using M-<next>/M-<prior>
  (setq helm-scroll-amount 8)

  ;;need to look up what this does
  (setq helm-ff-file-name-history-use-recentf t)

  ;;rebind tab to run persistent action
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

  ;;make TAB works in terminal 
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)

  ;;list actions using C-z
  (define-key helm-map (kbd "C-z")  'helm-select-action)

  ;;helm-M-x keybind
  (global-set-key (kbd "M-x") 'helm-M-x)

  ;;optional fuzzy matching for helm-M-x
  (setq helm-M-x-fuzzy-match t)

  ;;helm-show-kill-ring keybind
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  ;;helm-mini keybind
  (global-set-key (kbd "C-x b") 'helm-mini)

  ;;fuzzy matching for helm-mini
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)

  ;;helm-find-files
  (global-set-key (kbd "C-x C-f") 'helm-find-files)

  ;;enable search pattern in header line
  (setq helm-echo-input-in-header-line t)
  ;;and turn off minibuffer when using helm session
  (defun helm-hide-minibuffer-maybe ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                                `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)
  ;; enables helm completions for Emacs commands
  (helm-mode 1))

(projectile-global-mode)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))
