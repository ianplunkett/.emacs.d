;; Necessary for dired (otherwise displays errors)
(setq insert-directory-program "/usr/local/bin/gls")

;; PATH for eshell
( setenv "PATH"
	 (concat
	  (getenv "HOME") "/bin" ":"
	  (getenv "HOME") "/.npm-packages/bin" ":"
	  "/usr/local/bin" ":"
	  (getenv "PATH")))

;; El-Get Config
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Magit Config
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")


;; JavaScript IDE
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-indent-switch-body t)
 '(nodejs-repl-command "/usr/local/bin/node")
 '(org-agenda-files (quote ("~/Documents/org/gtd.org")))
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-hide-leading-stars t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Allow clearing of the eshell buffer
(defun eshell/clear ()
  "clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; Untabify on save for certain modes
(defun untab-all ()
  (untabify (point-min) (point-max))
  nil) ; did not write buffer to disk

(defun add-write-contents-hook ()
  (add-hook
   'write-contents-hooks
   'untab-all
   nil  ; APPEND
   t))  ; LOCAL

(add-hook 'js2-mode-hook #'add-write-contents-hook)
(add-hook 'php-mode-hook #'add-write-contents-hook)


;; PHP
(require 'auto-complete-etags)

;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "ON HOLD" "|" "DONE" "DELEGATED")))
(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("IN PROGRESS" . "OliveDrab4")
	("DONE" . (:foreground "blue" :weight bold))
	("DELEGATED" . (:foreground "blue" :weight bold))))

;; HTML
(setq web-mode-ac-sources-alist ())
(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-attribute-value
                         ac-source-html-tag
                         ac-source-html-attribute)))


;; easy creation of multiple eshell buffers
(defun mulit-eshell (z)
  "Create a new eshell buffer"
  (interactive "sEnter shell name: ")
  (eshell `Z)
  (rename-buffer z))
