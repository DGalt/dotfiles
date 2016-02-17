;;; chiaro-theme.el --- Dark color theme for Emacs

;; Copyright (C) 2015  Daniel Galtieri

;; Author: Daniel Galtieri <daniel.galtieri@gmail.com>
;; URL: 
;; Version: 1.0.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Commentary:

;; Credits:

;; The structure of this theme was based on zenburn-theme.el by Bozhidar Batsov and
;; badger-theme.el by Cody Canning

;;; Code:# 81969a, 8190be

(deftheme chiaro "Chiaro color theme")

;;; Color Palette:

(defvar chiaro-colors-alist
  '(("chiaro-fg"      . "#A2B5EE")
    ("chiaro-fg+1"    . "#3A5980")
    ("chiaro-bg"      . "#293134")
    ("chiaro-bg+1"    . "#343E42")
    ("chiaro-bg+2"    . "#4a595f")
    ("chiaro-bg-1"    . "#23292C")
    
    ("chiaro-gray"    . "#707F98")
    ("chiaro-slate"   . "#678CB1")
    ("chiaro-cyan"    . "#6BBEE8")
    ("chiaro-sea"     . "#3cb371")
    ("chiaro-green"   . "#93C763")
    ("chiaro-pink"    . "#E4A0D8")
    ("chiaro-pink-1"  . "#9F7097")
    ("chiaro-purple"  . "#A082BD")
    ("chiaro-red"     . "#8b0000")
    ("chiaro-orange"  . "#FF9E41")
    ("chiaro-orange-1". "#B26E2D")
    ("chiaro-yellow"  . "#FFCD22")
    ("chiaro-white"   . "#E0E2E4")
    ))
   
    
    
     
(defmacro chiaro-with-color-variables (&rest body)
  "`let' bind all colors defined in `chiaro-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   chiaro-colors-alist))
     ,@body))

;;; Theme Faces
(chiaro-with-color-variables
 (custom-theme-set-faces
  'chiaro

;;;;Built-in
;;;;; basic coloring
  `(default ((t (:foreground ,chiaro-fg :background ,chiaro-bg))))
  `(fringe ((t (:foreground ,chiaro-fg :background ,chiaro-bg))))
  `(cursor ((t (:foreground ,chiaro-fg :background ,chiaro-white))))
  `(escape-glyph ((t (:foreground ,chiaro-yellow :bold t))))
  `(highlight ((t (:foreground, chiaro-white :background ,chiaro-fg+1))))
  `(region ((t (:foreground, chiaro-white :background ,chiaro-fg+1))))
  `(link ((t (:foreground ,chiaro-cyan :underline t))))
  `(link-visited ((t (:foreground ,chiaro-sea :underline t))))
  `(success ((t (:foreground ,chiaro-cyan :weight bold))))
  `(warning ((t (:foreground ,chiaro-red :weight bold))))
  `(show-paren-match ((t (:background ,chiaro-green :foreground ,chiaro-white))))
  `(show-paren-mismatch ((t (:background ,chiaro-red :foreground ,chiaro-white))))
  `(vertical-border ((t (:foreground ,chiaro-gray))))
  
;;;;; Isearch
  `(lazy-highlight ((t (:background ,chiaro-pink-1 :foreground ,chiaro-fg :weight extra-bold))))
  `(isearch ((t (:background ,chiaro-orange-1 :foreground ,chiaro-white :weight extra-bold))))
  `(isearch-fail ((t (:foreground ,chiaro-fg :background ,chiaro-red))))

;;;;; Mode-line
   `(mode-line    ((,class (:foreground ,chiaro-gray
                                        :background , chiaro-bg-1
                                       ;; :box (:line-width -1 :style released-button)
                                        ))
                   (t :inverse-video nil)))

   `(mode-line-inactive ((t (:background ,chiaro-bg+1 :foreground ,chiaro-gray :box nil))))
   `(mode-line-buffer-id ((t (:foreground ,chiaro-cyan))))
   `(minibuffer-prompt ((t (:foreground ,chiaro-purple))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,chiaro-purple))))
   `(font-lock-comment-face ((t (:foreground ,chiaro-gray))))
   ;;`(font-lock-comment-delimiter-face ((t (:foreground ,zenburn-green-1))))
   `(font-lock-constant-face ((t (:foreground ,chiaro-pink))))
   ;;`(font-lock-doc-face ((t (:foreground ,zenburn-green+2))))
   `(font-lock-function-name-face ((t (:foreground ,chiaro-cyan))))
   `(font-lock-keyword-face ((t (:foreground ,chiaro-orange))))
   ;;`(font-lock-negation-char-face ((t (:foreground ,zenburn-yellow :weight bold))))
   ;;`(font-lock-preprocessor-face ((t (:foreground ,zenburn-blue+1))))
   ;;`(font-lock-regexp-grouping-construct ((t (:foreground ,zenburn-yellow :weight bold))))
   ;;`(font-lock-regexp-grouping-backslash ((t (:foreground ,zenburn-green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,chiaro-green))))
   `(font-lock-type-face ((t (:foreground ,chiaro-slate))))
   `(font-lock-variable-name-face ((t (:foreground ,chiaro-white))))
   `(font-lock-warning-face ((t (:foreground ,chiaro-red :weight bold))))

   ;;`(c-annotation-face ((t (:inherit font-lock-constant-face))))

;;;;; highlight current line
   `(hl-line-face ((,class (:background ,chiaro-bg+1))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,chiaro-bg+1)) ; old emacsen
              (t :weight bold)))
   
;;;; Third Party
;;;; company-mode
   `(company-preview-common ((,class (:foreground ,chiaro-white :background ,chiaro-red))))
   `(company-scrollbar-bg ((,class (:background ,chiaro-bg-1))))
   `(company-scrollbar-fg ((,class (:background ,chiaro-bg+2))))
   `(company-tooltip ((,class (:foreground ,chiaro-gray :background ,chiaro-bg+1))))
   `(company-tooltip-annotation ((,class (:foreground ,chiaro-purple :background ,chiaro-bg+1))))
   `(company-tooltip-common ((,class (:foreground ,chiaro-orange-1 :background ,chiaro-bg+1))))
   `(company-tooltip-common-selection ((,class (:weight bold :foreground ,chiaro-orange :background ,chiaro-bg+2))))
   `(company-tooltip-selection ((,class (:foreground ,chiaro-white :background ,chiaro-bg+2))))
;;;;;Helm
   `(helm-header ((,class (:background ,chiaro-bg :foreground ,chiaro-green))))
   `(helm-selection ((,class (:background ,chiaro-bg+1 :foreground ,chiaro-white, :weight: bold))))
   `(helm-source-header ((,class (:background ,chiaro-bg-1 :foreground ,chiaro-orange-1 :height 1.2))))
;;;;;ein (emacs-ipython-notebook)
   `(ein:cell-input-area ((,class (:background ,chiaro-bg))))
   `(ein:cell-input-promt ((,class (:background ,chiaro-bg+1 :foreground ,chiaro-white))))	      
  ))


;;; Theme Variables
(chiaro-with-color-variables
  (custom-theme-set-variables
   'chiaro
;;;;; ansi-color
   `(ansi-color-names-vector [,chiaro-fg, chiaro-bg])

;;;;; fill-column-indicator
   `(fci-rule-color ,chiaro-bg+1)
;;; pos-tip
   `(pos-tip-background-color ,chiaro-bg+1)
   `(pos-tip-foreground-color ,chiaro-white)
   '(pos-tip-border-width 0)
   '(pos-tip-internal-border-width 0)
   ))

;;;work around for ein to change default font background-color
(defun switch-color ()
  "Switch default bg and fg for ipython notebook."
  (face-remap-add-relative 'default '((:background "#343E42"))))
(add-hook 'ein:notebook-multilang-mode-hook 'switch-color)

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'chiaro)


;;; chiaro-theme.el ends here
    
