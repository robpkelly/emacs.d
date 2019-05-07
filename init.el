;;; init.el --- Configuration for Emacs
;;; by Rob Kelly <rpkelly@sandia.gov>
;;; Code:

;;; "Custom" settings -- autogenerated, avoid editing where possible...
;; {{{
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "firefox")
 '(c-basic-offset 4)
 '(c-default-style "linux")
 '(column-number-mode t)
 '(default-fill-column 80)
 '(frame-background-mode (quote dark))
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold nil)
    '(package-selected-packages
         (quote
             (idle-highlight-in-visible-buffers-mode color-theme-modern markdown-mode lua-mode slime yaml-mode editorconfig form-feed autopair elpy company-quickhelp flycheck py-autopep8 magit)))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;}}}

;;; Package installation
;; {{{
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			                ("melpa" . "https://melpa.org/packages/")
			                ("org" . "http://orgmode.org/elpa/")))

(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

(mapc #'(lambda (package)
	        (unless (package-installed-p package)
	            (package-install package)))
    package-selected-packages)
;; }}}

;;; Load external modules
;; {{{
(add-to-list 'load-path "~/.emacs.d/elisp")

(load "theme")
;; }}}

;;; General emacs behavior
;; {{{

;; Global keybindings
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "C-f") 'dabbrev-expand)
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x <C-left>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <C-right>") 'next-multiframe-window)
(global-set-key (kbd "C-n") 'isearch-forward-symbol-at-point)

(require 'clone-line)
(global-set-key (kbd "M-:") (lambda () (interactive) (clone-line t)))
;; }}}

;;; Major mode config
;; {{{

;;; Python configuration
(require 'elpy)
(elpy-enable)
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt")

;; use Flycheck
(when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

(defun my-elpy-mode-hook ()
    "Personal elpy hook logic"
    (interactive)
    (set-fill-column 120)
    (idle-highlight-in-visible-buffers-mode))
(add-hook 'elpy-mode-hook 'my-elpy-mode-hook)

;; ;; autopep8 on save
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;; }}}

;;; minor mode config
;; {{{

;; Autopair
(require 'autopair)
(autopair-global-mode)

;; Whitespace-mode
(require 'whitespace)
(global-set-key (kbd "C-x w") 'whitespace-mode)

(require 'flycheck)
(defun my-flycheck-mode-hook ()
    "Personal flycheck-mode hook logic"
    (interactive)
    (local-set-key (kbd "C-c <C-left>") 'flycheck-previous-error)
    (local-set-key (kbd "C-c <C-right>") 'flycheck-next-error))
(add-hook 'flycheck-mode-hook 'my-flycheck-mode-hook)

;; Editorconfig
(require 'editorconfig)
(editorconfig-mode 1)

;; Company-quickhelp
(require 'company-quickhelp)
(company-quickhelp-mode)

;; }}}
(put 'downcase-region 'disabled nil)
