;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/run/current-system/sw/bin/fish")
(setq-default explicit-shell-file-name "/run/current-system/sw/bin/fish")

(setq user-full-name "Nor Führ"
      user-mail-address "nor@acorneroftheweb.com")

(setq doom-font (font-spec :family "DokiDokiMono Nerd Font" :size 20)
      doom-big-font (font-spec :family "DokiDokiMono Nerd Font" :size 40)
      doom-variable-pitch-font (font-spec :family "DokiDokiMono Nerd Font" :size 26))

;; (setq doom-theme 'doom-one-light)
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'latte)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(map! ("M-i" 'vterm))

(setq vterm-shell "/usr/bin/env fish")

(evil-snipe-mode +1)
(evil-snipe-override-mode +1)

(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (width . 106) ; chars
              (height . 60) ; lines
              (setq default-frame-alist
                    '(
                      (width . 106)
                      (height . 60)))))))

(setq scroll-margin 7
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1
      doom-modeline-icon t
      doom-modeline-time-icon nil
      evil-want-fine-undo t)

(display-time-mode 1)

(when (string= (system-name) "scorpia")
  (add-hook 'after-init-hook #'fancy-battery-mode)
  (setq fancy-battery-show-percentage t))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(add-hook! '+doom-dashboard-functions :append)
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
(setq fancy-splash-image "~/.config/doom/splash.svg")

(global-visual-line-mode t)

(defun evil-normal-visual-motion (key command)
  (define-key evil-normal-state-map key command)
  (define-key evil-visual-state-map key command)
  (define-key evil-motion-state-map key command))

(evil-normal-visual-motion (kbd "j") 'evil-next-visual-line)
(evil-normal-visual-motion (kbd "k") 'evil-previous-visual-line)

(require 'agda-input)
(add-hook 'evil-insert-state-entry-hook (lambda ()
                                          (if (not (or (eq major-mode 'lean4-mode)
                                                       (eq major-mode 'latex-mode)
                                                       (eq major-mode 'LaTeX-mode)
                                                       (eq major-mode 'org-mode)
                                                       (eq major-mode 'vterm-mode)))
                                              (set-input-method "Agda"))))
(add-hook 'evil-insert-state-exit-hook  (lambda () (set-input-method nil)))

(setq company-idle-delay nil)
(setq default-frame-alist '((undecorated . t)))

(add-to-list 'auto-mode-alist '("\\.qnt" . quint-mode))
(require 'lsp-quint)
(use-package! lsp-quint
  :hook (quint-mode . lsp)
  :init (require 'quint-mode))

(set-buffer-multibyte 't)
