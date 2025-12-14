(doom! :set-eglot t       ;; Use eglot instead of lsp-mode (a lighter, often simpler alternative)
       :completion ivy    ;; A robust completion framework

       :ui
       doom              ;; The dark theme is a must
       doom-dashboard    ;; A quick launch screen
       
       :editor
       evil              ;; THE VIM KEYBINDINGS (Modal editing)
       file-templates    ;; Snippets for new files

       :emacs
       dired             ;; The Emacs file manager (Magit uses this)
       
       :tools
       ;; The key modules that convinced you to switch
       magit             ;; The best Git interface 
       vterm             ;; Fast terminal emulator (for Fish shell inside Emacs)
       
       :lang
       org               ;; The Literate Programming, notes, and agenda tool
       ;; :lang org is the base, but add these for full power:
       (org +attach +babel +capture +export +noter)
       
       ;; Other language modes (Uncomment these!)
       (cc +lsp)         ;; C/C++ with Language Server Protocol (clangd)
       (rust +lsp)       ;; Rust with Language Server Protocol (rust-analyzer)
       (haskell +lsp)    ;; Haskell with Language Server Protocol (haskell-language-server)
       emacs-lisp        ;; For hacking on your config!
       
       :app
       ;; (rss)             ;; If you want an integrated RSS reader
       )
