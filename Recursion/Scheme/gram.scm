#lang racket
(require racket/trace)


(provide parse)

;;Given a grammar gram and a list of tokens toks, return #t
;;iff the tokens toks are a sentence in the language defined
;;by gram; return #f otherwise.
;;
;;The token list toks consists of a list of 2-element lists; the first
;;element of each two element list is a Scheme symbol (starting with
;;an uppercase letter) representing the token kind and the second
;;element is a Scheme string representing the token lexeme.
;;
;;The grammar is represented as a nested list structure.  Specifically:
;;
;;   A grammar is represented as a list of rules.
;;   Each rule is represented as a pair.
;;     The first element of a rule pair is a non-terminal symbol
;;     The second element of a rule pair is a list of rule RHSs.
;;   A rule RHS is represented as a (possibly empty) list of
;;   terminal and non-terminal symbols.
;;
;;Terminal symbols are represented as Scheme symbols starting
;;with an uppercase letter whereas non-terminal symbols are
;;Scheme symbols which are not terminal symbols.
(define (parse gram toks)
  (parse-nonterm gram toks (caar gram))
  )
;(trace parse)

(define (parse-nonterm gram toks nonterm)
  (parse-rhss gram toks nonterm)
  )
;(trace parse-nonterm)

(define (parse-rhss gram toks rhss)
  (if (equal? rhss '())
      #f
      (parse-rhs gram toks (car rhss)) or (parse-rhss gram toks (cdr rhss))
      )
  )
;(trace parse-rhss)

(define (parse-rhs gram toks rhs)
  (if (equal? rhs '())
      toks
      (parse-sym gram toks (car rhs))
      )
  )
;(trace parse-rhs)

(define (parse-sym gram toks sym)
  '())
;(trace parse-sym)

;;; Utility Functions

;;return list of all RHSs for nonterm in grammar gram
(define (rhss gram nonterm) (cdr (assoc nonterm gram)))

;;return true iff sym is a terminal symbol (identifier starting with
;;uppercase letter)
(define (terminal? sym) (regexp-match #px"^[A-Z]" (symbol->string sym)))

