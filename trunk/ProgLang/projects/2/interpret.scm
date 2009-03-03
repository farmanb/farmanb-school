;=============================================================
;| FUNCTION TABLE
;|------------------------------------------------------------
;|
;| The function table is a list bound to the globaly defined
;| symbod "fun-table"
;|
;| SYNTAX:
;| -------
;| - The <FUNCTION TABLE> is a list of <FUNCTION ENTRIES>
;| - Each function entry is a pair (<FUN-SIGNATURE> <FUN-NAME>)
;| - A <FUN-NAME> can be any valid Scheme symbol
;| - A <FUN-SIGNATURE> is a list (<TYPE> <OP> <TYPE)
;| - Each <TYPE> in a signature is either "NUM" or "LIST"
;| - An <OP> in a signature is either "+" or "-", for the extra  
;| credit it would also include "*"
;|
;|


;- - - - - - - - - - - - - - - - - - - -
; fun-table
;
; gobal symbold that contains the function table
;

(define fun-table
  '( ((NUM + NUM) fun-num-plus-num)
     ((LIST + LIST) fun-list-plus-list)
     ((NUM - NUM) fun-num-minus-num)
     ((LIST - LIST) fun-list-minus-list)
     ((NUM * NUM) fun-num-times-num)
     ((LIST * LIST) fun-list-times-list)
     ((NUM * LIST) fun-num-times-list)
     ((LIST * NUM) fun-list-times-num)
     ))


;- - - - - - - - - - - - - - - - - - - -
; access functions for function signatures
;

(define (get-fun-signature FunEntry)
  (car FunEntry) )

(define (get-fun-name FunEntry)
  (cadr FunEntry) )


;- - - - - - - - - - - - - - - - - - - -
; (make-signature tv1 op tv2)
;
; this function creates a functions signature
; by looking up the types in the type-values
; tv1 and tv2 and then combining it with
; the operator symbol
;


(define (make-signature tv1 op tv2)
  (list (typeval-get-type tv1)
	op
	(typeval-get-type tv2) ) )


;- - - - - - - - - - - - - - - - - - - -
; (fun-lookup FunSignature)
;
; This function receives a function signature
; and returns the matching function from the
; function table
;
; NOTE: Don't just return the NAME of the functions,
; but rather the ACTUAL FUNCTON that is bound to the name
;

(define (fun-lookup FunSignature)
  (eval
   (myfoldl
    (lambda (Found Next)
      (if (equal?
	   FunSignature
	   (get-fun-signature Next) )
	  (get-fun-name Next)
	  Found )   )
    'undef-fun-entry
    fun-table ) ) )




;============================================================
; Functions supported by interpreted language
;------------------------------------------------------------
; These are the functions / operations that
; are supported by the interpreted languages
;


;- - - - - - - - - - - - - - - - - - - -
; (fun-num-plus-num tv1 tv2)
;
; * a function that receive two type-value pairs of type NUM
;
; * it adds the values and returns a type-value pair of type NUM
;
; **** IMPLEMENT THIS ****
;

(define (fun-num-plus-num tv1 tv2)
  (make-typeval 
   (typeval-get-type tv1) 
   (+ (typeval-get-val tv1) (typeval-get-val tv2) )
   )
)




;- - - - - - - - - - - - - - - - - - - -
; (fun-num-minus-num tv1 tv2)
;
; * a function that receive two type-value pairs of type NUM
;
; * it subtracts the values and returns a type-value pair of type NUM
;
; **** IMPLEMENT THIS ****

(define (fun-num-minus-num tv1 tv2)
  (make-typeval
   (typeval-get-type tv1)
   (- (typeval-get-val tv1) (typeval-get-val tv2))
   )
  )


;- - - - - - - - - - - - - - - - - - - -
; (fun-list-plus-list tv1 tv2)
;
; * a function that receives two type-value pairs of type LIST
;   that each contain a list OF EQUAL LENGTH
;
; * it returns a LIST, a list where the first element
;   is a pair of the first elements of the two lists, the second element
;   is a pair of the second elements, ... etc.
;
; * EXAMPLE:
;   ========
; 		(fun-list-plus-list
; 			'(LIST (1 2 3))
; 			'(LIST (a b c)) )
;
; 	returns:
; 		(LIST ( (1 a) (2 b) (3 c)))
;
; **** IMPLEMENT THIS ****

(define (make-list l1 l2)
  (cond
   ( (eq? (cdr l1) '()) 
     (list (list (car l1) (car l2))))
   (else
    (cons (list
	   (car l1)
	   (car l2))
	  (make-list (cdr l1) (cdr l2)))
   )
  )
)
  

(define (fun-list-plus-list tv1 tv2)
  (make-typeval (typeval-get-type tv1) 
		(make-list (typeval-get-val tv1) (typeval-get-val tv2))
		)
  )

;- - - - - - - - - - - - - - - - - - - -
; (fun-list-minus-list tv1 tv2)
;
; * a function that receives two type-value pairs of type LIST
;
; * it returns a LIST, a list that contains all elements
;   from the first list, without the elments from the second list
;
; * EXAMPLE:
;   ========
; 		(fun-list-minus-list
; 			'(LIST (1 2 3 4 5))
; 			'(LIST (2 4 6 8 10 12 )) )
;
; 	returns:
; 		(LIST ( 1 3 5 ) )
;
; **** IMPLEMENT THIS ***

(define (is-empty List)
  (eq? List '())
)

(define (are-both-empty l1 l2)
  (cond 
   ((eq? (is-empty l1) #t)
    (eq? (is-empty l2) #t)
    )
   (else
    #f
    )
   )
  )

(define (is-equivalent-list l1 l2)
  (cond 
   ((are-both-empty l1 l2) #t)
   ;One empty, the other non-empty,
   ;therefore not equivalent
   ((eq? l1 '()) #f)
   ((eq? l2 '()) #f)
    ;(l1 != '() && l2 != '()) && 
    ;((car l1) == (car l2))
   ((eq? 
     ;l1 != '() && l2 != '()
    (eq? 
     (are-both-empty l1 l2) #f)
    ;(car l1) == (car l2)
    (eq? (car l1) (car l2))
     )
    (is-equivalent-list (cdr l1) (cdr l2)))
   (else
    #f)
   )
)

(define (item-in-list List Item)
  (cond
   ((list? Item) (list-in-list List Item))
   (else
    (cond 
   ;The List is empty, obviously the Item is not
   ;in the List, return false.
     ( (eq? List '()) #f )
   ;The Item is in the List, return true.
     ((eq? Item (car List)) #t)
   ;The Item hasn't been found, the List is not exhausted,
   ;keep looking.
     (else (item-in-list (cdr List) Item) )
     )
    )
   )
  )

(define (list-in-list List ItemList)
  (cond
   ;The list is empty, obviously the ItemList is not
   ;in the List, return false.
   ( (eq? List '()) #f )
   ;The next element of List is not a list,
   ;keep going.
   ( (eq? (list? (car List)) #f)
     (list-in-list (cdr List) ItemList))
   ((eq? (is-equivalent-list (car List) ItemList) #t) #t)
   (else
    (list-in-list (cdr List) ItemList) )
   )
)

(define (is-equivalent-item Item1 Item2)
  (cond
   ( (list? Item1)
     (cond
      ;If one item is a list, and the other is not,
      ;they are obviously not equivalent
      ( (eq? (list? Item2) #f) #f)
      (else
       (is-equivalent-list Item1 Item2)
       )
      )
     )
   (else
    (eq? Item1 Item2)
    )
   )
  )

(define (rem-from-list List Item)
  (cond
   ;If the list is empty, do nothing:  Can't subtract
   ;anyting from an empty list.
   ( (eq? List '()) List )
   ;Check to see if the entry exists
   ;Entry does not exist in the list
   ( (eq? (item-in-list List Item) #f)
     ;Do nothing.  The item we want to delete is not in here.
     List)
   ;Entry does exist, remove it.
   (else 
    ;Rebuild the list.
    (cond 
     ;Check to see if the first entry is the one we want to remove
     ( (is-equivalent-item Item (car List))
       ;If it is the first, get rid of the current entry and call 
       ;rem-from-list.  This will cause rem-from-list to think the entry 
       ;does not exist, return the list and cause the two pieces to be
       ;appended, excluding the Item.	 
     (rem-from-list (cdr List) Item))
     ;Otherwise, 
    (else 
     ;append the first entry to the new env and keep going.
     (cons (car List) (rem-from-list (cdr List) Item))
     )
    )
   )
  )
)

(define (fun-list-minus-list tv1 tv2)
  (cond
   ( (eq? (typeval-get-val tv2) '()) tv1)
   (else
    (fun-list-minus-list 
     (make-typeval (typeval-get-type tv1)
		   (rem-from-list (typeval-get-val tv1)
				  (car (typeval-get-val tv2))))
     (make-typeval (typeval-get-type tv2)
		   (cdr (typeval-get-val tv2))))
    )
   )
  )


;- - - - - - - - - - - - - - - - - - - -
; **** EXTRA CREDIT ****
;
; (num-times-num tv1 tv2)
;
; - multiplies the two number in tv1 and tv2
; **** IMPLEMENT THIS (EXTRA CREDIT) ****

(define (fun-num-times-num tv1 tv2)
  (make-typeval 
   (typeval-get-type tv1) 
   (* (typeval-get-val tv1) (typeval-get-val tv2) )
   )
)


;- - - - - - - - - - - - - - - - - - - -
; **** EXTRA CREDIT ****nn
;
; (list-times-list tv1 tv2)
;
; - generates a list of all pairs with element from both lists
; **** IMPLEMENT THIS (EXTRA CREDIT) ****

(define (merge-lists l1 l2)
  (cond
   ;Base case, last element in l2, return that
   ;as the starting list
   ( (eq? (cdr l2) '()) (list (car l2)))
   ;l1 exhausted, start appending l2
   ( (eq? l1 '()) (cons (car l2) (merge-lists l1 (cdr l2))) )
   (else(cons (car l1) (merge-lists (cdr l1) l2)))
   )
)

(define (mult-list-by-item List Item)
  (cond 
   ( (eq? (cdr List) '())
     (list (list  Item (car List)))
     )
     (else
      (cons (list Item (car List)) (mult-list-by-item (cdr List) Item))
      )
     )
  )

(define (mult-lists l1 l2)
  (cond
   ( (eq? (cdr l1) '()) 
     (mult-list-by-item l2 (car l1))
     )
   (else 
    (merge-lists (mult-list-by-item l2 (car l1))
	  (mult-lists (cdr l1) l2))
    )
   )
  )

(define (fun-list-times-list tv1 tv2)
  (make-typeval (typeval-get-type tv1) (mult-lists (typeval-get-val tv1) (typeval-get-val tv2)))
  )



;- - - - - - - - - - - - - - - - - - - -
; **** EXTRA CREDIT ****
;
; (num-times-list k L)
;
; - creates a list that contains the each element of L k many times
;
; EX: (num-times-list 3 ( a b c ) )  ---> ( a a a  b b b c c c  )
; **** IMPLEMENT THIS (EXTRA CREDIT) ****

(define (mult-num-by-list k L)
  (cond
   ( (eq? (cdr L) '())
     (mult-list-by-num (car L) k)
     )
   (else
    (merge-lists (mult-list-by-num (car L) k) (mult-num-by-list k (cdr L)))
    )
   )
  )
(define (fun-num-times-list k L)
  (make-typeval (typeval-get-type L) (mult-num-by-list (typeval-get-val k) (typeval-get-val L)))
  )


;- - - - - - - - - - - - - - - - - - - -
; **** EXTRA CREDIT ****
;
; (list-times-num k L)
;
; - appends the list L k times with itself
;
; EX: (num-times-list  '( a b c ) 3)  ---> ( (a b c) (a b c) (a b c) )
; **** IMPLEMENT THIS (EXTRA CREDIT) ****

(define (mult-list-by-num L k)
  (cond 
   ( (eq? k 1) 
     (list L)
     )
   (else 
    (cons L (mult-list-by-num L (- k 1)))
    )
   )
  )
(define (fun-list-times-num L k)
  (make-typeval (typeval-get-type L) (mult-list-by-num (typeval-get-val L) (typeval-get-val k)))
  )





;=============================================================
;| TypeValues
;|------------------------------------------------------------
;| * All data that is stored in variables, passed into functions,
;|   or returned from functions is represented as <TYPE-VALUES>.
;|   (short "typeval")
;|
;|  A <TYPE-VALUE> is a pair (<TYPE> <VALUE>) of the data type
;|  followed by the value
;|
;|


;- - - - - - - - - - - - - - - - - - - -
; Access functions to work with TypeValues
;
(define (make-typeval t v) (list t v))

(define (typeval-get-type tv) (car tv))

(define (typeval-get-val tv) (cadr tv))




;=============================================================
;| ENVIRONMENT
;|------------------------------------------------------------
;|
;| The environment is a list that contains variable bindings
;| to types/values.  Expressions will always be evaluated
;| in the context of an environment.
;|
;| SYNTAX:
;| -------
;| - The <ENVIRONMENT> is a list of <VARIABLE ENTRIES>
;| - Each variable entry is a pair (<VARIABLE_NAME> <TYPE-VALUE>)
;| - A <VARIABLE-NAME> can be any valid Scheme symbol
;| - The <TYPE-VALUE> is a pair that stores the datatype of the  
;|   variable,
;|   followed by the stored value
;|
;|


;- - - - - - - - - - - - - - - - - - - -
; Environment Access Functions

(define (get-var-name VarEntry)
   (car VarEntry) )

(define (get-type-value VarEntry)
   (cadr VarEntry) )

(define (get-var-type VarEntry)
   (caadr VarEntry) )

(define (get-var-value VarEntry)
   (cadadr VarEntry) )

;- - - - - - - - - - - - - - - - - - - -
; (env-lookup Env VarName)
;
; - This functions returns the TypeValue that is bound
;   to variable "VarName" in the environment.
;
; - if variable is not present in environment,
;   it returns undef-var-entry (a symbol that is
;   bound to an error message)
;
; **** IMPLEMENT THIS ****

(define (env-lookup Env VarName)
  (cond 
   ( (eq? Env '()) undef-var-entry )
   ( (eq? VarName (car (car Env))) (get-type-value (car Env)) )
   (else 
    (env-lookup (cdr Env) VarName) )
   )
)

;- - - - - - - - - - - - - - - - - - - -
; (env-update Env VarEntry)
;
; This functions updates the variable entry for a given variable
; (The environment may or may not contain such an entry yet)
;
;  - VarEntry has the same syntax as a <VARIABLE-ENTRY> in the
;  environment
;
; **** IMPLEMENT THIS ****

(define (add-env-entry Env EnvEntry)
  (cons EnvEntry Env)
  )

(define (env-update Env VarEntry)
  (cond
   ;If the environment is empty, append the VarEntry to it.
   ( (eq? Env '()) (add-env-entry Env VarEntry) )
   ;Check to see if the entry exists
   ;Entry does not exist, add one.
   ( ( eq? (env-lookup Env (get-var-name VarEntry)) undef-var-entry)
     (add-env-entry Env VarEntry ))
   ;Entry does exist, update it.
   (else 
    ;Rebuild the list.
    (cond 
     ;Check to see if the first entry is the one we want to update
     ( (eq? (get-var-name VarEntry) (car (car Env)) ) 
       ;If it is the first, get rid of the current entry and call 
       ;env-update.  This will cause env-update to think the entry 
       ;does not exist and add it.
       (env-update (cdr Env) VarEntry))
     ;Otherwise, 
     (else 
       ;append the first entry to the new env and keep going.
       (cons (car Env) (env-update (cdr Env) VarEntry)) )
     )
   )
  )
)
 
;============================================================
; EVALUATING EXPRESSIONS, STATEMENTS and PROGRAMS
;------------------------------------------------------------
;
; SYNTAX:
; =======
;
; - A <PROGRAM> is a list of STATEMENTS
; - A <STATEMENT> is a list of the form (<VARNAME> <- <EXPR>)
; 	note, <- is a terminal symbol here
;   (EX:  ( a <- 3 + b )
;
; - An <EXPR> is either a <BINARY-EXPRESSUION>
; 	or <SINGLE-ARGUMENT>
; - A <SINGLE-ARGUMENT> is constant value (a number, or a list)
;   or a variable name
; - A <BINARY-EXPRESSION> is a list of the form
;   (<SINGLE-ARUGMENT> <OP> <SINGLE-ARGUMENT>)
; - Here <OP> is either + or - (or for extra credit *)
;
;


;- - - - - - - - - - - - - - - - - - - -
; (eval-expression Env E)
;
; This function evaluates the <EXPRESSION> E in the
; context of environment Env
;
; it returns a Type-Value pair representing the
; value of the expression E
;
; **** IMPLEMENT THIS ****

(define (expression-get-arg1 E)
  (cond
   ( (number? E) E)
   (else
    (car E)
    )
   )
  )

(define (expression-get-op E)
  (cond
   ( (number? E) '())
   (else
    (let (
	  (tail (cdr E))
	  )
      (cond
       ((eq? tail '()) '() )
       (else (car tail))
       )
      )
    )
   )
  )


(define (expression-get-arg2 E)
  (cond
   ( (number? E) '())
   (else
    (let (
	  (tail (cdr E))
	  )
      (cond
       ( (eq? tail '()) '() )
       (else
	(cadr tail)
	)
       )
      )
    )
   )
  )

(define (expand-arg Env Arg)
  (let (
	  (EnvVar (env-lookup Env Arg))
	  )
  (cond
   ( (eq? '() Arg) '())
   ;If it's in the environment, return the
	;expansion.
   ( (eq? (eq? EnvVar undef-var-entry) #f)
     EnvVar
     )
   ;If it isn't, check to see if it's a list.
   ( (eq? (list? Arg) #t)
    ;Check to see what type of list.
     (cond 
       ;If it's already a typeval, return.
       ( (eq? (car Arg) 'NUM) Arg )
       ( (eq? (car Arg) 'LIST) Arg )
       ;If it's none of the above, it's just a list,
       ;create a new typeval and return that.
       (else
	(make-typeval 'LIST Arg)
	)
       )
      )
   ;Otherwise, it's a number, create a new typeval.
   (else 
    (make-typeval 'NUM Arg)
    )
    )
  )
)
   
(define (eval-expression Env E)
  (let (
	(arg1 (expand-arg Env (expression-get-arg1 E)))
	(op (expression-get-op E))
	(arg2 (expand-arg Env (expression-get-arg2 E)))
	)
    (cond
     ((eq? op '()) arg1)
     (else
      ((fun-lookup 
	(make-signature 
	 arg1
	 op
	 arg2))
       arg1
       arg2)
      )
     )
    )
  )
 
;- - - - - - - - - - - - - - - - - - - -
; (eval-statement Env S)
;
; This function evaluates a <STATEMENT>
; in the context of environment Env
;
; In the process the expression in the statement
; is evaluated and the resulting Type-Value pair
; is stored (= updated in the Environment)
; in the variable indicated in the statement
;
; The function returns the environment after
; evaluating the statement
;
; **** IMPLEMENT THIS ****

(define (statement-get-lhs S)
  (car S)
)

(define (statement-get-op S)
  (cadr S)
)

(define (statement-get-rhs S)
  (cdr (cdr S))
)

(define (eval-statement Env S)
  (letrec (
	(VarName (statement-get-lhs S))
	(Expression (statement-get-rhs S))
	)
    (eval-expression Env Expression)
    (env-update Env (list 
		     VarName 
		     (eval-expression Env Expression)))
    )
)

;- - - - - - - - - - - - - - - - - - - -
; (eval-statements Env S)
;
; This function evaulates an entire
; list of statements from left to right
; and updates the the environment
; as it goes
;
; The function returns the
; environment after evaluating the
; last statement
;
; **** IMPLEMENT THIS ****

(define (eval-statements Env S)
  (let (
	(NewS (cdr S))
	)
    (cond
     ( (eq? NewS '()) 
       (eval-statement Env (car S))
       )
     (else
      (eval-statements (eval-statement Env (car S)) (cdr S))
      )
     )
     )
    )



;- - - - - - - - - - - - - - - - - - - -
; (eval-statements Env S)
;
; This function evaluates an entire
; program (a list of statement),
; starting with an initially emptyu
; environment

(define (eval-program P)
   (eval-statements '() P) )



;============================================================
; ERROR values
;------------------------------------------------------------
;
; These error values defined here can be used

(define undef-var-entry '(ERROR: undefined variable ))


(define (undef-fun-entry  X Y) '(ERROR: undefined function))


;============================================================
; Accessories
;============================================================
;
; The function listed here may be useful to the students.
;


;------------------------------------------------------------
; TOOLS
;

(define (member? x L)
   (myfoldl
	(lambda (found next)
	  (or found
               (eq? next x) ) )
   	#f
   	L ) )


(define (myfoldr f l base)
   (if (null? l)
       base
       (f (car l) (myfoldr f (cdr l) base))))


(define (myfoldl f base l )
   (if (null? l)
		base
		(myfoldl f (f base (car l)) (cdr l)) ) )



;------------------------------------------------------------
; BASIC TEST-DATA
;

(define stmt-list
  '( (x <- 4) (y <- 7) (z <- x + y) ) )

(define test-env
  '( (a (NUM 7))
     (b (NUM -3))
     (L1 (LIST '(1 2 3 4 5)))
     (L2 (LIST '(2 3 6 7 8))) ) )

(define test-program
  '(
    ( a1 <- 3 )
    ( b1 <- 5 )
    ( c1 <- a1 + b1)
    ( d1 <- a1 - b1)
    ( e1 <- a1 + 7)
    ( a2 <- (1 2 3 4 5) )
    ( b2 <- (2 3 6 7 8) )
    ( c2 <- a2 + b2)
    ( d2 <- a2 - b2)
    ) )



(define test-program2
  '(
    ( a1 <- 3 )
    ( b1 <- 5 )
    ( c1 <- a1 + b1)
    ) )
