;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; command-log
     react
     windows-scripts
     yaml
     sql
     dash
     pdf-tools
     ;; lsp
     search-engine
     (javascript :variables javascript-disable-tern-port-files nil)
     ivy
     (go :variables
         go-tab-width 4
         gofmt-command "goimports"
         )

     (auto-completion :variable
                    auto-completion-return-key-behavior 'complete
                    auto-completion-tab-key-behavior 'cycle
                    auto-completion-complete-with-key-sequence nil
                    auto-completion-enable-sort-by-usage t
                    auto-completion-enable-snippets-in-popup t
                    auto-completion-enable-help-tooltip t
                    )

     better-defaults
     restclient
     (ibuffer
      :variables
      ibuffer-group-buffers-by nil)
     emacs-lisp
     (python :variables
             python-test-runner 'pytest
             python-enable-yapf-format-on-save nil
             )
     colors
     html
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode)
     (git
      :variables
      git-magit-status-fullscreen t)
     markdown
     github
     (org :variables
          org-enable-github-support t
          org-enable-hugo-support t)
     nginx
     (shell
      :variables
      shell-default-term-shell "/usr/bin/zsh"
      shell-protect-eshell-prompt nil)

     ;; (spacemacs-layouts :variables layouts-enable-autosave t
     ;;                    layouts-autosave-delay 300)
     (spell-checking :variables spell-checking-enable-by-default nil)
     (syntax-checking
      :variables
      syntax-checking-enable-tooltips t)
     (version-control :variables
                      version-control-global-margin t
                      version-control-diff-tool 'diff-hl)
     wtx-edit
     wtx-org
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(fcitx go-autocomplete)
   ;; A list of packages that will not be install and loaded.
   dotspacemacs-excluded-packages '(evil-unimpaired)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https nil
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                       hybrid-mode-enable-evilified-state t
                                       hybrid-mode-enable-hjkl-bindings t
                                       )
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs buildj
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; dotspacemacs-startup-banner 'doge
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '((recents . 15)
                                (projects . 10))
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'restclient-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         monokai
                         doom-one
                         leuven
                         spacemacs-dark
                         spacemacs-light
                         solarized-dark
                         solarized-light
                         zenburn
                         )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 17
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq configuration-layer--elpa-archives
        '(("melpa-cn" . "https://elpa.emacs-china.org/melpa/")
          ("org-cn"   . "https://elpa.emacs-china.org/org/")
          ("gnu-cn"   . "https://elpa.emacs-china.org/gnu/")))
  (setq socks-server '("Default server" "127.0.0.1" 1080 5))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq-default git-enable-magit-svn-plugin t)
  (setq tramp-copy-size-limit nil)
  (setq url-http-attempt-keepalives nil)
  ;; (setq tramp-default-method "ssh")
  ;; (setq tags-table-list (list "~/js-project/js/TAGS" "~/js-project/css/TAGS"))
  ;; (setq powerline-default-separator 'utf-8)
  (fcitx-evil-turn-on)
  (global-company-mode)
  (smartparens-global-mode)
  ;; (golden-ratio-mode t)
  (add-hook 'python-mode-hook (lambda () (electric-indent-local-mode -1)))
  (global-hl-line-mode -1)
  (setenv "SSH_ASKPASS" "git-gui--askpass")
  (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (define-key evil-normal-state-map "t" 'avy-goto-char)
  ;; (setq url-proxy-services
  ;;       '(("no_proxy" . "^\\(127.0.0.1\\|localhost\\j10.*\\)")
  ;;         ("http" . "127.0.0.1:6152")
  ;;         ("https" . "127.0.0.1:6152")))

  )


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#eee8d5" t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (org-mime epl go-guru go-eldoc flycheck-gometalinter company-go go-mode org-category-capture ghub let-alist bind-key iedit goto-chg undo-tree ox-mediawiki evil-goggles ox-hugo counsel-tramp ox-gfm engine-mode etags-select elfeed-web elfeed-org elfeed-goodies noflet elfeed zeal-at-point counsel-dash helm-dash doom-monokai-theme nov esxml diminish avy packed evil async f s winum unfill ob-restclient fuzzy company-restclient know-your-http-well command-log-mode phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode magit-svn protobuf-mode pdf-tools tablist powershell yaml-mode powerline spinner counsel swiper smartparens highlight helm helm-core projectile hydra ivy dash monokai-theme fcitx company-web web-completion-data company-tern dash-functional tern company-statistics company-c-headers company-anaconda youdao-dictionary names chinese-word-at-point yapfify xterm-color wrap-region web-mode web-beautify visual-regexp tagedit sql-indent smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restclient rbenv rake rainbow-mode rainbow-identifiers pyvenv pytest pyenv-mode py-isort pug-mode pony-mode pip-requirements peep-dired pangu-spacing orgit org-projectile pcache org-present org org-pomodoro alert log4e gntp org-download ob-http nodejs-repl nginx-mode mwim multi-term mmm-mode minitest markdown-toc markdown-mode magit-gitflow livid-mode skewer-mode live-py-mode less-css-mode keyfreq json-mode json-snatcher json-reformat js2-refactor js2-mode js-doc impatient-mode simple-httpd ibuffer-projectile hy-mode htmlize helm-github-stars haml-mode gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md flyspell-correct-ivy flyspell-correct flycheck-pos-tip pos-tip flycheck-package package-lint flycheck evil-vimish-fold vimish-fold evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help emmet-mode disaster diff-hl cython-mode company color-identifiers-mode coffee-mode cmake-mode clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg clang-format cider-eval-sexp-fu cider queue clojure-mode chruby bundler inf-ruby beacon seq auto-yasnippet yasnippet auto-dictionary anaconda-mode pythonic ace-pinyin pinyinlib ace-jump-mode ac-ispell auto-complete solarized-theme ws-butler window-numbering which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spacemacs-theme spaceline smex restart-emacs request rainbow-delimiters quelpa popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-make google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word counsel-projectile column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#eee8d5" t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (lsp-ui lsp-python lsp-javascript-typescript typescript-mode lsp-go company-lsp lsp-mode org-mime epl go-guru go-eldoc flycheck-gometalinter company-go go-mode org-category-capture ghub let-alist bind-key iedit goto-chg undo-tree ox-mediawiki evil-goggles ox-hugo counsel-tramp ox-gfm engine-mode etags-select elfeed-web elfeed-org elfeed-goodies noflet elfeed zeal-at-point counsel-dash helm-dash doom-monokai-theme nov esxml diminish avy packed evil async f s winum unfill ob-restclient fuzzy company-restclient know-your-http-well command-log-mode phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode magit-svn protobuf-mode pdf-tools tablist powershell yaml-mode powerline spinner counsel swiper smartparens highlight helm helm-core projectile hydra ivy dash monokai-theme fcitx company-web web-completion-data company-tern dash-functional tern company-statistics company-c-headers company-anaconda youdao-dictionary names chinese-word-at-point yapfify xterm-color wrap-region web-mode web-beautify visual-regexp tagedit sql-indent smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restclient rbenv rake rainbow-mode rainbow-identifiers pyvenv pytest pyenv-mode py-isort pug-mode pony-mode pip-requirements peep-dired pangu-spacing orgit org-projectile pcache org-present org org-pomodoro alert log4e gntp org-download ob-http nodejs-repl nginx-mode mwim multi-term mmm-mode minitest markdown-toc markdown-mode magit-gitflow livid-mode skewer-mode live-py-mode less-css-mode keyfreq json-mode json-snatcher json-reformat js2-refactor js2-mode js-doc impatient-mode simple-httpd ibuffer-projectile hy-mode htmlize helm-github-stars haml-mode gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md flyspell-correct-ivy flyspell-correct flycheck-pos-tip pos-tip flycheck-package package-lint flycheck evil-vimish-fold vimish-fold evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help emmet-mode disaster diff-hl cython-mode company color-identifiers-mode coffee-mode cmake-mode clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg clang-format cider-eval-sexp-fu cider queue clojure-mode chruby bundler inf-ruby beacon seq auto-yasnippet yasnippet auto-dictionary anaconda-mode pythonic ace-pinyin pinyinlib ace-jump-mode ac-ispell auto-complete solarized-theme ws-butler window-numbering which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spacemacs-theme spaceline smex restart-emacs request rainbow-delimiters quelpa popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-make google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word counsel-projectile column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
)
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-mode-manager helm-flx helm-descbinds helm-ag evil-unimpaired ace-jump-helm-line zenburn-theme zeal-at-point youdao-dictionary yasnippet-snippets yapfify yaml-mode xterm-color ws-butler wrap-region winum which-key wgrep web-mode web-beautify vue-mode volatile-highlights visual-regexp vi-tilde-fringe uuidgen use-package unfill toml-mode toc-org tagedit symon string-inflection sql-indent spaceline-all-the-icons solarized-theme smex smeargle slim-mode shell-pop scss-mode sass-mode rjsx-mode restart-emacs request rainbow-mode rainbow-identifiers rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode protobuf-mode prettier-js powershell popwin pippel pipenv pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode peep-dired pcre2el password-generator paradox pangu-spacing ox-mediawiki ox-hugo ox-gfm overseer orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file ob-restclient ob-http nov nodejs-repl nginx-mode neotree nameless mwim multi-term move-text monokai-theme markdown-toc magithub magit-svn magit-gitflow magit-gh-pulls macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-navigator json-mode js2-refactor js-doc ivy-yasnippet ivy-xref ivy-rtags ivy-purpose ivy-hydra indent-guide importmagic impatient-mode ibuffer-projectile hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-make helm-github-stars google-translate google-c-style golden-ratio godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc go-autocomplete gnuplot gitignore-templates gitignore-mode github-search github-clone gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md fuzzy font-lock+ flyspell-correct-ivy flycheck-rust flycheck-rtags flycheck-pos-tip flycheck-package flx-ido fill-column-indicator fcitx fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-vimish-fold evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help engine-mode emmet-mode elisp-slime-nav editorconfig dumb-jump drupal-mode dotenv-mode doom-themes doom-modeline disaster diminish diff-hl define-word cython-mode counsel-tramp counsel-projectile counsel-dash counsel-css company-web company-tern company-statistics company-rtags company-restclient company-php company-go company-c-headers company-anaconda column-enforce-mode color-identifiers-mode clean-aindent-mode clang-format centered-cursor-mode cargo browse-at-remote beacon auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent ace-window ace-pinyin ace-link ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
