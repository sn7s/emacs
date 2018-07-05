(add-to-list 'load-path "~/.emacs.d/lisp/")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backward-delete-char-untabify-method nil)
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(cua-mode t nil (cua-base))
 '(ecb-layout-window-sizes (quote (("simple" (0.3247863247863248 . 0.2537313432835821) (0.3247863247863248 . 0.26865671641791045) (0.3247863247863248 . 0.4626865671641791)))))
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((sgml-parent-document . "pixfmt.sgml"))))
 '(save-place t nil (saveplace))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 94 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


;; Dont' make me type 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;(setq tab-width 8)
;;(setq c-basic-offset 4)
(setq-default tab-width 8)


;;(require 'xcscope)
(require 'column-marker)
(require 'auto-complete)
(require 'auto-complete-etags)
(require 'auto-complete-extension)
;;(require 'semantic-ia)
;;g(require 'semanticdb)
(require 'uniquify)
(require 'session)

(add-hook 'after-init-hook 'session-initialize)
(desktop-save-mode 1)

;;(semantic-add-system-include "~/dev/linux-opensource/kernel" 'c-mode)
; Show name of the current function in status line
;;(semantic-load-enable-excessive-code-helpers)
; Enable prototype help and smart completion
;;<<(semantic-load-enable-code-helpers)
;;(setq semantic-load-turn-useful-things-on t)
(global-auto-complete-mode t)
;;(global-gtags-mode t)
;;<<(global-semanticdb-minor-mode 1)

;; enable support for gnu global
;;(require 'semanticdb-global)
;;(semanticdb-enable-gnu-global-databases 'c-mode)
;;(semanticdb-enable-gnu-global-databases 'c++-mode)
;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;;(semantic-load-enable-primary-exuberent-ctags-support)
;;(require 'semantic-gcc)

;;<<(setq semanticdb-project-roots
;;<<         (list "/home/snawrocki/devel/linux-opensource/kernel"))

;;<<(setq-mode-local c-mode semanticdb-find-default-throttle
;;<<	'(project unloaded system recursive))

;;<<(defun my-cedet-hook ()
;;<<  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;<<  (local-set-key "\C-c>" 'semantic-ia-complete-symbol-menu)
;;  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;<<  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
;;<<(add-hook 'c-mode-common-hook 'my-cedet-hook)


;; marker at 80'th column
(add-hook 'font-lock-mode-hook (lambda () (interactive) (column-marker-1 80)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (font-lock-add-keywords nil
		'(("\\<\\(FIXME\\|XXX\\|TODO\\|BUG\\|BUG_ON\\):" 1 font-lock-warning-face t)))
	    (gtags-mode 1)))


(define-key global-map (kbd "C-/") 'undo)
(define-key global-map (kbd "C-x C-/") 'redo)
;; display list of buffers in active window rather than splitting windows
(define-key global-map (kbd "C-x C-b") 'buffer-menu)

(define-key global-map (kbd "M-,") 'gtags-find-rtag)
(define-key global-map (kbd "C-.") 'find-tag)
(define-key global-map (kbd "C-*") 'pop-tag-mark)
;;(define-key global-map (kbd "M-x M-w") 'white-space-mode)
;;(define-key global-map (kbd "C-x C-o") 'cscope-find-this-symbol)
(global-set-key [f9] 'whitespace-mode)

;; disable splash screen
(setq inhibit-splash-screen t)

;; disable bell function
(setq ring-bell-function 'ignore)

;; current buffer name in title bar
(setq frame-title-format "%b")

;; start emacs server
(server-start)

;; disable scrollbar
(toggle-scroll-bar -1)

;; disable toolbar
(tool-bar-mode -1)
(menu-bar-mode -1)

; always show line numbers
(global-linum-mode 1)

;highlight matching parenthesis
(show-paren-mode t)

;;(setq truncate-lines t)         ;wrap lines

(c-add-style
 "snawrocki"
 '((c-basic-offset . 8) ; 8-char wide indention...
   (tab-width . 8) ; ...which equals single tab...
   (indent-tabs-mode . t) ; ...so use tabs
   (c-comment-only-line-offset . 0) ; XXX no idea what it does
   (c-label-minimum-indentation . 1) ; no min. indention for labels

   (c-cleanup-list ; Clean ups
    brace-else-brace ; "} else {" in one line
    brace-elseif-brace ; "} else if (...) {" in one line
    brace-catch-brace ; "} catch (...) {" in one line
    defun-close-semi ; "};" together
    )

   (c-offsets-alist ; Indention levels:
    ; Don't indent inside namespaces, extern, etc
    (incomposition . 0)
    (inextern-lang . 0)
    (inmodule . 0)
    (innamespace . 0)

    ; Preprocessor macros
    (cpp-define-intro c-lineup-cpp-define +)
    (cpp-macro . [ 0 ])
    (cpp-macro-cont . +)

    ; Brace after newline newer indents
    (block-open . 0)
    (brace-entry-open . 0)
    (brace-list-open . 0)
    (class-open . 0)
    (composition-open . 0)
    (defun-open . 0)
    (extern-lang-open . 0)
    (inline-open . 0)
    (module-open . 0)
    (namespace-open . 0)
    (statement-case-open . 0)
    (substatement-open . 0)

    ; Obviously, do not indent closing brace
    (arglist-close . 0)
    (block-close . 0)
    (brace-list-close . 0)
    (class-close . 0)
    (composition-close . 0)
    (defun-close . 0)
    (extern-lang-close . 0)
    (inline-close . 0)
    (module-close . 0)
    (namespace-close . 0)

    ; Obviously, indent next line after opening brace and single statements
    (defun-block-intro . +)
    (statement-block-intro . +)
    (substatement . +)

    ; Handle nicely multi line argument lists
    (arglist-close c-lineup-arglist 0)
    (arglist-cont mn-c-lineup-argcont c-lineup-gcc-asm-reg +)
    (arglist-cont-nonempty mn-c-lineup-argcont c-lineup-gcc-asm-reg c-lineup-arglist +)
    (arglist-intro . c-lineup-arglist-intro-after-paren)

    ; Misc
    (brace-list-intro . +) ; Indent elements in brace-lists
    (brace-list-entry . 0)
    (c . c-lineup-C-comments) ; Indent comments nicely
    (comment-intro . c-lineup-comment)
    (catch-clause . 0) ; catch/finally where try
    (do-while-closure . 0) ; while (...) where do
    (else-clause . 0) ; else where if
    (func-decl-cont . +) ; Indent stuff after function
    (friend . 0) ; friend need no additional indention
    (inclass . +) ; Indent stuff inside class...
    (access-label . -) ; ...expect for access labels
    (inexpr-statement . 0) ; No unneeded indent in ({ ... })...
    (inexpr-class . 0) ; ...& anonymous classes
    (inher-intro . +) ; ndent & lineup inheritance list
    (inher-cont . c-lineup-multi-inher)
    (member-init-intro . +) ; Indent & lineup initialisation list
    (member-init-cont . c-lineup-multi-inher)
    (label . [ 0 ]) ; Labels always on first column
    (substatement-label . [ 0 ])
    (statement . 0) ; Statement same as line above...
    (statement-cont c-lineup-cascaded-calls +) ; ...but indent cont.
    (statement-case-intro . +) ; Indent statements in switch...
    (case-label . 0) ; ...but not the labels
    (stream-op . c-lineup-streamop) ; Lineup << operators in C++
    (string . c-lineup-dont-change) ; Do not touch strings!
    (template-args-cont c-lineup-template-args +) ; Lineup template args
    (topmost-intro . 0) ; Topmost stay topmost
    (topmost-intro-cont c-lineup-topmost-intro-cont 0)

    ; Other stuff I don't really care about
    ; I keep it here for the sake of having all symbols specified.
    (inlambda . c-lineup-inexpr-block)
    (knr-argdecl . 0)
    (knr-argdecl-intro . +)
    (lambda-intro-cont . +)
    (objc-method-args-cont . c-lineup-ObjC-method-args)
    (objc-method-call-cont
     ;c-lineup-ObjC-method-call-colons
     c-lineup-ObjC-method-call +)
    (objc-method-intro . [0])
    )

   ; I don't care about anything that is below -- not using any
   ; automagick -- but for the sake of having everything set I'll keep
   ; it here.

   (c-hanging-braces-alist ; Auto new lines around braces
    ; In most cases new line after open brace and both before and
    ; after close brace. The "before" is however ommited
    ; from *-close symbols because when editing normally we will
    ; be on the new line already -- if we're not, user probably
    ; knows better.
    (defun-open after)
    (defun-close after)
    (class-open after)
    (class-close after)
    (inline-open after)
    (inline-close after)
    (extern-lang-open after)
    (extern-lang-close after)
    (namespace-open after)
    (namespace-close after)
    (module-open after)
    (module-close after)
    (composition-open after)
    (composition-close after)

    ; No new line after closing brace if it matches do { or if (...) {
    (block-open after)
    (substatement-open after)
    (block-close . c-snug-do-while)

    ; With brace-lists however, do nothing automatically -- user knows
    ; better
    (brace-list-open )
    (brace-list-close )
    (brace-list-intro )
    (brace-entry-open )

    ; Others
    (statement-cont )
    (statement-case-open after)
    (inexpr-class-open )
    (inexpr-class-close )
    (arglist-cont-nonempty )
    )

   (c-hanging-colons-alist
    ; Add new line after labels
    (case-label after)
    (label after)
    (access-label after)
    ; But nothing else
    (member-init-intro )
    (inher-intro )

    (c-hanging-semi&comma-criteria
     (mn-c-semi&comma-no-newlines-if-open-brace
      c-semi&comma-no-newlines-before-nonblanks
      c-semi&comma-inside-parenlist))
    )))

(defun mn-c-semi&comma-no-newlines-if-open-brace ()
  "Prevents newline after semicolon if there is an open brace
on the same line. Function is a bit stupid and does not check if
the open brace was real open brace or part of comment/string."
  (when (let ((p (point))) (save-excursion (forward-line 0)
                                           (search-forward "{" p t)))
    'stop))

(defun mn-c-lineup-argcont (elem)
  "Line up a continued argument's operands (assumes there
will be a single space after an operator ifit starts the line).

foo(xyz, aaa +
         bbb <- c-lineup-argcont
       + ccc <- c-lineup-argcont
      << ccc <- c-lineup-argcont
      == eee); <- c-lineup-argcont
if (foo
 || bar) <- c-lineup-argcont

Only continuation lines like this are touched, nil is returned on lines
which are the start of an argument.

Within a gcc asm block, \":\" is recognized as an argument separator,
but of course only between operand specifications, not in the expressions
for the operands.

Works with: arglist-cont, arglist-cont-nonempty."
  (let ((ret (c-lineup-argcont elem)))
    (if (and (vectorp ret)
             (save-excursion
               (back-to-indentation)
               (looking-at
                (eval-when-compile
                  (regexp-opt
                   (list
                    "+" "+=" "++" "-" "-=" "--" "*" "*=" "/" "/=" "%"
                    "%=" "^" "^=" "&" "&=" "&&" "|" "|=" "||" "<<"
                    "<<=" ">>" ">>=" "<" "<=" ">" ">=" "=" "==" ":"
                    "::" "?"))))))
        (vector (- (elt ret 0) (- (match-end 0) (match-beginning 0)) 1))
      ret)))

(setq c-default-style '((awk-mode . "awk")
                        (other . "snawrocki")))


;(defun linux-c-mode ()
;	"C mode with adjusted defaults for use with the Linux kernel."
;	(interactive)
;	(c-mode)
;	(setq c-indent-level 8)
;	(setq c-brace-imaginary-offset 0)
;	(setq c-brace-offset -8)
;	(setq c-argdecl-indent 8)
;	(setq c-label-offset -8)
;	(setq c-continued-statement-offset 8)
;	(setq indent-tabs-mode t)
;	(setq tab-width 8))


;(setq auto-mode-alist (cons '("/home/snawrocki/dev/linux-opensource/kernel/.*\\.[ch]$" . linux-c-mode)
;	auto-mode-alist))


;;}}}
;;{{{   Save with no blanks

;; Save with no trailing whitespaces
;; XXX there is a delete-trailing-whitespace function which might be
;; added to write-file-hooks.
(defun save-no-blanks (&optional arg) (interactive "P")
  (unless arg
    (save-excursion
      (save-restriction
        (widen)
        (goto-char 0) (perform-replace "[ \t]+$" "" nil t nil)
        (goto-char (point-max))
        (unless (>= (skip-chars-backward "\n") -2)
          (delete-region (1+ (point)) (point-max))))))
  (save-buffer))

(substitute-key-definition 'save-buffer 'save-no-blanks (current-global-map))
;(global-set-key "\C-x\C-s"      'save-no-blanks)
;;}}}}

;;{{{{
(defun reload-file ()
  (interactive)
  (let ((curr-scroll (window-vscroll)))
    (find-file (buffer-name))
    (set-window-vscroll nil curr-scroll)
    (message "Reloaded file")))

(global-set-key "\C-c\C-r" 'reload-file)
;;}}}


;;pace-mode use “¶” for newline and “▷” for tab.
;; together with the rest of its defaults
(setq whitespace-display-mappings
 '(
   (space-mark 32 [183] [46]) 	; normal space
   (space-mark 160 [164] [95])
   (space-mark 2208 [2212] [95])
   (space-mark 2336 [2340] [95])
   (space-mark 3616 [3620] [95])
   (space-mark 3872 [3876] [95])
   (newline-mark 10 [182 10]) 	; newline
   (tab-mark 9 [9655 9] [92 9]) ; tab
))


;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
	backup-by-copying t      ; don't clobber symlinks
	backup-directory-alist
	'(("." . "~/.saves"))    ; don't litter my fs tree
	delete-old-versions t
	kept-new-versions 6
	kept-old-versions 2
	version-control t)       ; use versioned backups

; since 22.1 this is on by defaault
(global-set-key [(f3)] 'kmacro-start-macro-or-insert-counter)
(global-set-key [(f4)] 'kmacro-end-or-call-macro)


;;;; Highliht #if/#else/#endif
(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
