;;; packages.el --- wtxlayer Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq wtxlayer-packages
      '(
        company
        company-anaconda
        ;; (comint-mode :location built-in)
        yasnippet
        ace-pinyin
        js2-mode
        avy
        chinese-pyim
        youdao-dictionary
        pangu-spacing
        helm-github-stars
        deft
        js-comint
        nodejs-repl
        web-mode
        impatient-mode
       ;; chinese-fonts-setup
      ))

;; List of packages to exclude.
(setq wtxlayer-excluded-packages '())


(defun wtxlayer/init-impatient-mode ()
  "Initialize impatient mode"
  (use-package impatient-mode
    :init
    (progn
      (defun wtx-mode-hook ()
        "my web mode hook for HTML REPL"
        (interactive)
        (impatient-mode)
        (httpd-start))
      (add-hook 'web-mode-hook 'wtx-mode-hook)
      (evil-leader/set-key-for-mode 'web-mode
        "p" 'imp-visit-buffer)
)))


(defun wtxlayer/init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    (progn
      (spacemacs/declare-prefix-for-mode 'js2-mode
                                         "me" "evaluating")
      (evil-leader/set-key-for-mode 'js2-mode
        "eb" 'nodejs-repl-eval-buffer))
    )
)

(defun wtxlayer/init-js-comint ()
  (use-package js-comint
    :init
    (progn
      ;; http://stackoverflow.com/questions/13862471/using-node-js-with-js-comint-in-emacs
      (setq inferior-js-mode-hook
            (lambda ()
              ;; We like nice colors
              (ansi-color-for-comint-mode-on)
              ;; Deal with some prompt nonsense
              (add-to-list
               'comint-preoutput-filter-functions
               (lambda (output)
                 (replace-regexp-in-string "\033\\[[0-9]+[GKJ]" "" output)))))
      (setq inferior-js-program-command "node"))))

(defun wtxlayer/post-init-web-mode ()
  (setq company-backends-web-mode '((company-dabbrev-code
                                     company-keywords
                                     company-etags)
                                    company-files company-dabbrev)))

(defun wtxlayer/post-init-js2-mode ()
  (progn
    (remove-hook 'js2-mode-hook 'flycheck-mode)
    (defun conditional-disable-modes ()
      (when (> (buffer-size) 50000)
        (flycheck-mode -1)))

    (evil-leader/set-key-for-mode 'js2-mode
      "ed" 'nodejs-repl-eval-dwim
      "tb" 'zilong/company-toggle-company-tern)

    (evil-leader/set-key-for-mode 'js2-mode
      "ga" 'projectile-find-other-file
      "gA" 'projectile-find-other-file-other-window)

    (evil-leader/set-key-for-mode 'web-mode
      "ga" 'projectile-find-other-file
      "gA" 'projectile-find-other-file-other-window)
    (eval-after-load 'js2-mode
      '(progn
         (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))
         (define-key js2-mode-map   (kbd "s-.") 'company-tern)))

    ;; (add-hook 'js2-mode-hook 'which-function-mode)
    (add-hook 'js2-mode-hook 'conditional-disable-modes)
    (add-hook 'js2-mode-hook '(lambda ()
                                (local-set-key "\C-x\C-e" 'js-send-last-sexp)
                                (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
                                (local-set-key "\C-cb" 'js-send-buffer)
                                (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                                (local-set-key "\C-cl" 'js-load-file-and-go)
                                ))

    (spacemacs/declare-prefix-for-mode 'js2-mode "ms" "repl")
    (evil-leader/set-key-for-mode 'js2-mode
      "sr" 'js-send-region
      "sR" 'js-send-region-and-go
      "sb" 'js-send-buffer
      "sB" 'js-send-buffer-and-go
      "sd" 'js-send-last-sexp
      "sD" 'js-send-last-sexp-and-go
      "gd" 'helm-etags-select)


    (use-package js2-mode
      :defer t
      :config
      (progn
        ;; these mode related variables must be in eval-after-load
        ;; https://github.com/magnars/.emacs.d/blob/master/settings/setup-js2-mode.el
        (setq-default js2-allow-rhino-new-expr-initializer nil)
        (setq-default js2-auto-indent-p nil)
        (setq-default js2-enter-indents-newline nil)
        (setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
        (setq-default js2-idle-timer-delay 0.1)
        (setq-default js2-mirror-mode nil)
        (setq-default js2-strict-inconsistent-return-warning nil)
        (setq-default js2-include-rhino-externs nil)
        (setq-default js2-include-gears-externs nil)
        (setq-default js2-concat-multiline-strings 'eol)
        (setq-default js2-rebind-eol-bol-keys nil)
        (setq-default js2-auto-indent-p t)

        (setq-default js2-bounce-indent nil)
        (setq-default js-indent-level 4)
        (setq-default js2-basic-offset 4)
        (setq-default js2-indent-switch-body t)
        ;; Let flycheck handle parse errors
        (setq-default js2-show-parse-errors nil)
        (setq-default js2-strict-missing-semi-warning t)
        (setq-default js2-highlight-external-variables t)

        (add-hook 'js2-mode-hook
                  #'(lambda ()
                      (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
                      (define-key js2-mode-map "@" 'js-doc-insert-tag)))

        (defun js2-toggle-indent ()
          (interactive)
          (setq js-indent-level (if (= js-indent-level 2) 4 2))
          (setq js2-indent-level (if (= js-indent-level 2) 4 2))
          (setq js2-basic-offset (if (= js-indent-level 2) 4 2))
          (message "js-indent-level, js2-indent-level, and js2-basic-offset set to %d"
                   js2-basic-offset))

        (evil-leader/set-key-for-mode 'js2-mode
          "oj" 'js2-toggle-indent)
        (spacemacs/declare-prefix-for-mode 'js2-mode "mo" "toggle")

        (autoload 'flycheck-get-checker-for-buffer "flycheck")
        (defun sanityinc/disable-js2-checks-if-flycheck-active ()
          (unless (flycheck-get-checker-for-buffer)
            (set (make-local-variable 'js2-mode-show-parse-errors) t)
            (set (make-local-variable 'js2-mode-show-strict-warnings) t)))
        (add-hook 'js2-mode-hook 'sanityinc/disable-js2-checks-if-flycheck-active)
        (eval-after-load 'tern-mode
          '(spacemacs|hide-lighter tern-mode))
        ))

    (evilified-state-evilify js2-error-buffer-mode js2-error-buffer-mode-map)


    (defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Controller" "[. \t]controller([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Controller" "[. \t]controllerAs:[ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Filter" "[. \t]filter([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("State" "[. \t]state([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Factory" "[. \t]factory([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Service" "[. \t]service([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Module" "[. \t]module([ \t]*['\"]\\([a-zA-Z0-9_\.]+\\)" 1)
                                   ("ngRoute" "[. \t]when(\\(['\"][a-zA-Z0-9_\/]+['\"]\\)" 1)
                                   ("Directive" "[. \t]directive([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Event" "[. \t]\$on([ \t]*['\"]\\([^'\"]+\\)" 1)
                                   ("Config" "[. \t]config([ \t]*function *( *\\([^\)]+\\)" 1)
                                   ("Config" "[. \t]config([ \t]*\\[ *['\"]\\([^'\"]+\\)" 1)
                                   ("OnChange" "[ \t]*\$(['\"]\\([^'\"]*\\)['\"]).*\.change *( *function" 1)
                                   ("OnClick" "[ \t]*\$([ \t]*['\"]\\([^'\"]*\\)['\"]).*\.click *( *function" 1)
                                   ("Watch" "[. \t]\$watch( *['\"]\\([^'\"]+\\)" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Class" "^[ \t]*var[ \t]*\\([0-9a-zA-Z]+\\)[ \t]*=[ \t]*\\([a-zA-Z]*\\).extend" 1)
                                   ("Class" "^[ \t]*cc\.\\(.+\\)[ \t]*=[ \t]*cc\.\\(.+\\)\.extend" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))

    (add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))
    ))

(defun wtxlayer/post-init-yasnippet()
  (progn
    (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
    (mapc #'(lambda (hook) (remove-hook hook 'spacemacs/load-yasnippet)) '(prog-mode-hook
                                                                           org-mode-hook
                                                                           markdown-mode-hook))
    (defun wtx/load-yasnippet ()
      (unless yas-global-mode
        (progn
          (yas-global-mode 1)
          (setq my-snippet-dir (expand-file-name "~/demo/snippets"))
          (setq yas-snippet-dirs  my-snippet-dir)
          (yas-load-directory my-snippet-dir)
          (setq yas-wrap-around-region t)))
      (yas-minor-mode 1))

    (spacemacs/add-to-hooks 'wtx/load-yasnippet '(prog-mode-hook
                                                            markdown-mode-hook
                                                            org-mode-hook))))

(when (configuration-layer/layer-usedp 'auto-completion)

  ;; Hook company to comint-mode, comint-mode is a inferior mode in emacs
  (defun wtxlayer/post-init-company ()
    (spacemacs|add-company-hook comint-mode))

  ;; Add the backend to the major-mode specific backend list, it can not work to pushing company-anaconda, why?
  (defun wtxlayer/post-init-company-anaconda ()
    (use-package company-anaconda
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :init (push 'company-anaconda company-backends-comint-mode))))


(defun wtxlayer/init-ace-pinyin ()
  (use-package ace-pinyin
    :init
    (progn
      (ace-pinyin-global-mode t)
      (setq ace-pinyin-use-avy t)
      (spacemacs|hide-lighter ace-pinyin-mode))))


(defun wtxlayer/init-chinese-pyim ()
  "Initialize chinese-pyim"
  (use-package chinese-pyim
    :init
    (progn
      (setq default-input-method "chinese-pyim")
      ;; (define-key evil-emacs-state-map (kbd "C-<SPC>") 'toggle-input-method))
      (global-set-key (kbd "C-<SPC>") 'toggle-input-method))
    :config
    (progn
      (setq pyim-use-tooltip t
            pyim-tooltip-width-adjustment 1.2
            pyim-dicts
            '((:name "SogouPY"
                     :file "~/dicts/sogou.pyim"
                     :coding utf-8-unix)))
    ;; switch to English input when helm buffer activate.u
            (setq pyim-english-input-switch-function
            'pyim-helm-buffer-active-p)
      ;; turn off evil escape when default input method (pyim) on.
      ;; if not, the first key of escap sequence will cause a problem
      ;; when trying to fast insert corresponding letter by hitting Enter.
      (add-hook 'input-method-activate-hook 'pyim-turn-off-evil-escape t)
      ;; after input method deactivated, turn on evil escape.
      (add-hook 'input-method-deactivate-hook 'pyim-turn-on-evil-escape t)
      )))

(defun wtxlayer/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :if chinese-enable-youdao-dict
    :defer
    :init
    (progn
      (evil-leader/set-key
        "ot" 'youdao-dictionary-search-at-point+))
    :config
    (progn
      ;; Enable Cache
      (setq url-automatic-caching t
            ;; Set file path for saving search history
            youdao-dictionary-search-history-file
            (concat spacemacs-cache-directory ".youdao")
            ;; Enable Chinese word segmentation support
            youdao-dictionary-use-chinese-word-segmentation t))))
(defun wtxlayer/init-pangu-spacing ()
  (use-package pangu-spacing
    :defer t
    :init (progn (global-pangu-spacing-mode 1)
                 (spacemacs|hide-lighter pangu-spacing-mode)
                 ;; Always insert `real' space in org-mode.
                 (add-hook 'org-mode-hook
                           '(lambda ()
                              (set (make-local-variable 'pangu-spacing-real-insert-separtor) t))))))

(defun wtxlayer/init-helm-github-stars ()
  (use-package helm-github-stars
    :defer t
    :config
    (progn
      (setq helm-github-stars-username "LonglyCode")
      (setq helm-github-stars-cache-file "~/.emacs.d/.cache/hgs-cache"))))

(defun wtxlayer/post-init-deft ()
  (setq deft-use-filter-string-for-filename t)
  (evil-leader/set-key-for-mode 'deft-mode "mq" 'quit-window)
  (setq deft-extension "org"))
