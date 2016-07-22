(when (> emacs-major-version 23)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/")
               ;; '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
               t)
  )

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Basic configurations
(setq frame-title-format '
      (:eval
       (if (buffer-file-name)
           (abbreviate-file-name (buffer-file-name))
         "%b")))
(load-theme 'molokai t) ;; add 't' at the end to auto-yes for any questions
(defalias 'list-buffers 'ibuffer)

;; Hide bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(column-number-mode)

;; Tab as spaces
(setq tab-stop-list (number-sequence 2 120 2))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Hide startup screen
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Disable system beep
(setq visible-bell t)

;; Prompts
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq delete-by-moving-to-trash t) ;; Delete by move file to trash
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)

;; Others
(show-paren-mode t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq dired-listing-switches "-aDhl  --group-directories-first")
(setq term-scroll-show-maximum-output t)
(winner-mode)
;; ========== End Preferrences ==========

;; Neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; flx-ido-mode
(require 'flx-ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(flx-ido-mode 1)

;; Smex - enhance M-x key
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Windmove
(require 'windmove)
(windmove-default-keybindings) ;; Use S-<arrow keys>
;; Other option
(global-set-key (kbd "C-S-j") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-i") 'windmove-up)
(global-set-key (kbd "C-S-k") 'windmove-down)

;; Projectile
(require 'projectile)
(setq projectile-enable-caching t)
;; Avoid hang when use overT RAMP
(setq projectile-file-exists-remote-cache-expire nil)
;; (setq projectile-remember-window-configs nil)
(setq projectile-mode-line '(:eval
                             (format " Proj[%s]" (projectile-project-name))))
(projectile-global-mode) ; enable globally mode
;; (setq projectile-require-project-root nil)
;; (add-hook 'ruby-mode-hook 'projectile-mode) ; enable Projectile for Ruby mode
;; Projectile-rails -  not compatible Rails 2.3.x
;; (require 'projectile-rails)
;; (add-hook 'projectile-mode-hook 'projectile-rails-on)

;; Helm
(require 'helm-config)
(add-hook 'ruby-mode-hook (lambda () (linum-mode)))
(add-hook 'js-mode-hook (lambda () (linum-mode)))

(require 'enh-ruby-mode)
(setq enh-ruby-bounce-deep-indent t)

(require 'ruby-end)
(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (ruby-end-mode) 
            (linum-mode)
            (smartscan-mode)
            ))

;; Yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;; Avoid keybindings TAB key conlilsion in term-mode 
(add-hook 'term-mode-hook (lambda () (yas-minor-mode -1)))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(eval-after-load 'minitest '(minitest-install-snippets))
;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
;; Alternatively use Control-c + tab
(define-key yas-minor-mode-map (kbd "\C-c TAB") 'yas-expand)

;; Open Recent Files
(require 'recentf)
;; get rid of `find-file-read-only' and replace it with something more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;; enable recent files mode.
(recentf-mode t)
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; Manual
(add-to-list 'load-path "~/.emacs.d/manual")
;; Ido-imenu
(require 'idomenu)
(setq imenu-auto-rescan 1)
(global-set-key (kbd "M-i") 'idomenu)
;; (load "extend_selection") ;; Select word, line (from ErgoEmacs)
;; (load "my_macro_functions")
;; (load "toggle_hiding")
;; (load "quick_web") ;; w3m
;; (load "tags_helpers")
(load "Highlight-Indentation-for-Emacs/highlight-indentation")
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#2f4f4f")
(set-face-background 'highlight-indentation-current-column-face "#2f4f4f")
(add-hook 'ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-hook 'js-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-hook 'go-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

;; Open Recent Files
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'js-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'go-mode)

(defun open-54-psql-shell ()
  "Quick open a psql shell connecting to 54 DB server"
  (interactive)
  (setq sql-user "postgres")
  (setq sql-port 6432)
  (setq sql-host "172.16.9.54")
  (setq sql-database "postgres")
  (sql-postgres "psql-54")
  )

;; Magit
(setq magit-completing-read-function 'magit-ido-completing-read)
(global-set-key (kbd "C-x g") 'magit-status)

;; Multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(add-hook 'before-save-hook 'gofmt-before-save)


;; Go-mode
(add-hook 'go-mode-hook
          (lambda ()
            (setq gofmt-command "goimports")
            (add-hook 'before-save-hook 'gofmt-before-save)
            (linum-mode)
            ))
(require 'go-autocomplete)

;; Show current file-path in minibuffer and copy it to kill ring (clip-board)
(defun copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (let ((buffer-path dired-directory))
    (when buffer-file-name
      (setq buffer-path buffer-file-name))
    (when buffer-path
      (message (concat "Copied full-path to clipboard: " buffer-path))
      (kill-new (file-truename buffer-path)))))

(global-set-key [C-f1] 'copy-full-path-to-kill-ring) ; Or any other key you want

(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (projectile-project-root)))
    (shell-command (concat "/usr/bin/ctags -e -R --extra=+fq --exclude=.git --exclude='**/ext*/*.js' -f " root "TAGS " root)))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (projectile-project-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun my-find-tag ()
  (interactive)
  (condition-case err
      (if (file-exists-p (concat (projectile-project-root) "TAGS"))
          (visit-project-tags)
        (build-ctags))
    (error
     (message "%s" (error-message-string err))
     ))
  (etags-select-find-tag))

(global-set-key (kbd "M-.") 'my-find-tag)

;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))

;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun extend-selection (arg &optional incremental)
  "Select the current word.
Subsequent calls expands the selection to larger semantic unit."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (use-region-p)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))

(global-set-key (kbd "M-8") 'extend-selection)

(require 'rubocop)
(setq ruby-insert-encoding-magic-comment nil)
(setq enh-ruby-add-encoding-comment-on-save nil)
