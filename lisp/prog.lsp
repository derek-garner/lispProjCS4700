(load "C:/Users/half-/Desktop/list/lisp/postscript.lsp")

(define (sort-functions lst)
	(if (empty? lst)
		lst
		map(sort-list lst)
	)

)
; Using insert, sort the list
(define (sort-list lst)
	(if (empty? lst)
		lst
		(insertInOrder (first lst)(sort-list(rest lst)))
	)
)

;Insert value x into the proper spot in an ordered list
(define (insertInOrder x lst)
	(if (empty? lst)
	 	(list x)
		(if (<= x (first lst))
			(append (list x) lst)
			(append (list(first lst)) (insertInOrder x (rest lst) ))
		)
	
	)
)


(define (compose f g) (expand (lambda (x) (f (g x))) 'f 'g))

;Create compositing of functions
(define (compose-list lst)
	(if(> 1 (length lst)) 
		lst
		(if(> 2 (length lst))
			(first lst)
			(compose (first lst) (compose-list (rest lst)))
		)
	)
 )




;Print alternating black and gray squares
(define (squares filename n) 
	(ps:gsave)
	(Rsquares filename n)	
	(ps:grestore)	

)

;Recursive square proceadure,
(define (Rsquares filename n) 
		
	(ps:goto (- 250 (* 20 n)) 250)
		(if (= (% n 2) 0)
			(drawsquare true 20)
			(drawsquare false 20)
		)
	(if(= n 1)
		(ps:save filename)
		(squares filename (- n 1))	
	)
)

; Simple function to draw a square either boolean (black or gray) sith size x		
(define (drawsquare black sizeX)
	
	(if(= black true)
	(ps:fill-color 0 0 0)
	(ps:fill-color .5 .5 .5)
	)

	(ps:rectangle sizeX sizeX true)

)

;Starting fractal function
(define (fractal filename dimension) 
	(ps:gsave)
		
	
	(setDefaultPos dimension)
	; (ps:draw 50)
	
	(rFractal dimension)
	(ps:save filename)
	(ps:grestore)
)

; Recursive fractal proceadure
(define (rFractal dimension)
	(if(= dimension 0)
		(ps:save filename)
		(if(= dimension 1)
			(oneDimension dimension) 
			(if(= dimension 2)
				(twoDimension dimension) 
				(if(> dimension 2)
					(aboveTwoDimensions dimension)
					
				)
			)
		)
	)	
)

;Case for more than two remaining dimensions
(define (aboveTwoDimensions dimension)
	
	(ps:gsave)
	(shiftRight)
	(rFractal (- dimension 1))
	(ps:grestore)
	(ps:gsave)
	(shiftLeft)
	(rFractal (- dimension 1))
	(ps:grestore)
	(ps:gsave)
	(rFractal (- dimension 1))
	(ps:grestore)


)

; Case for single dimension
(define (oneDimension dimension)
(ps:gsave)	
(ps:draw 75)
	(rFractal (- dimension 1))
(ps:grestore)
)

; Case for two remaining dimensions
(define (twoDimension dimension)
	(println '10)
	(println (- dimension 1))
	(drawRightLeg)
	
	(drawLeftLeg)
	
	(rFractal (- dimension 1))
	
)

; rotate and draw left in prep for rigt leg
(define (shiftLeft)
	(ps:scale .7 .7)
	(ps:translate 101 33)
	(ps:rotate 35)

)

; rotate and draw left in prep for left leg
(define (shiftRight)
	
	(ps:scale .7 .7)
	(ps:translate 80 203)
	(ps:rotate -35)
	
)
; rotate and draw left leg of fractal
(define (drawLeftLeg)
	(ps:gsave)
	(shiftLeft)
	(ps:draw 75)

	(ps:grestore)

)

; rotate and draw right leg of fractal
(define (drawRightLeg)
	(ps:gsave)
	(shiftRight)
	(ps:draw 75)
	(ps:grestore)

)

; Set position of fractal, used before recursive proceadure
(define (setDefaultPos dimension)
	
	(ps:goto 150 20)
	(ps:line-width 6)
	(ps:scale 2 2 )
	


)









