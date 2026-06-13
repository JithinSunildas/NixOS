;; ~/.config/doom/init.el

(doom! :input
       :completion
       company 
       (vertico +icons)      ; The UI for search/selection (like Telescope)

       :ui
       doom                ; what makes DOOM look DOOM
       doom-modeline       ; that nice bar at the bottom
       hl-todo             ; highlight TODO/FIXME/NOTE
       (popup +defaults)   ; taming popups
       unicode             ; extended unicode support
       (vc-gutter +pretty) ; gitsigns equivalent
       workspaces          ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere)  ; The vim emulation (Essential)
       file-templates      ; auto-snippets for empty files
       fold                ; (nigh) universal code folding
       (format +onsave)    ; auto-formatting (like your lsp.lua setup)
       rotate-text         ; cycle region at point (e.g. true <-> false)
       snippets            ; my precious
       word-wrap           ; soft wrapping with language-aware indent

       :emacs
       dired
       electric
       ibuffer
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       ;;debugger
       ;;direnv
       ;;docker
       ;;editorconfig
       ;; (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp +eglot)        ; M-x vscode
       magit
       ;;make              ; run make tasks from Emacs
       tree-sitter         ; syntax and parsing, significant speedups
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       clipboard
       tty

       :lang
       ;;agda              ; types of types of types of types...
       ;;beancount         ; mind the GAAP
       (cc +lsp)           ; C/C++/Obj-C madness (clangd)
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data                ; config/data formats
       ;; (dart +flutter +lsp) ; Flutter support (replaces flutter-tools.nvim)
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       ;;erlang            ; an elegant weapon for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       ;;fortran           ; in cold blood
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects
       ;;gdscript          ; the language you waited for
       (go +lsp)           ; the hipster dialect
       (haskell +lsp)      ; a language that's lazier than I am
       ;;hy                ; lispy python
       ;;idris             ; a language you can depend on
       json                ; At least it ain't XML
       (java +lsp)         ; the poster child for carpal tunnel syndrome
       (javascript +lsp)   ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better python
       ;;kotlin            ; a better java
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;lean              ; for folks with too much to prove
       ;;ledger            ; be audit you can be
       (lua +lsp)          ; one-based indices? one-based indices
       markdown            ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       (nix +lsp)          ; I heard you like OS configuration
       ;; (ocaml +lsp)        ; an objective camel
       (org +pretty)
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       ;; (python +lsp)       ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework
       ;;racket            ; a scheme for a plot
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReStructuredText
       ;;ruby              ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)         ; Fe2O3.ol
       ;;scala             ; java, but good
       ;;scheme            ; a fully conniving family of lisps
       ;; (sh +lsp)           ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       (web +lsp)          ; the tubes
       (yaml +lsp)         ; JSON, but readable
       (zig +lsp)          ; C, but simpler

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader

       :config
       ;;literate
       (default +bindings +smartparens))
