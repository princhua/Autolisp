(defun c:ttt ()
  (setq e1 (car (entsel"\nchoose ME:")) en (entget e1))
  (setq r (cdr(assoc 40 en)))
  (setq pt (list(cadr(assoc 10 en)) (caddr(assoc 10 en))))
  (COMMAND "layer"  "lo" "ME" "")
  (command "zoom" "a")
  (command "polygon" 200 pt "c" r)
  (setq e2(entget(entlast)))
	(setq l1(mapcar 'cdr(vl-remove-if'(lambda (x) (/= (car x) 10)) e2)))
	;| (setq l1
		 (vl-sort l1
			'(lambda (x1 x2)
				(setq p1 (car x1) p3 (cadr x1))
				(setq p2 (car x2) p4 (cadr x2))
				(if (equal p1 p2 0.01) (> p3 p4) (< p1 p2))
			)
		) 
	) 
	(setq pt1 (car l1))
	(setq pt2(nth 3 l1))
	(setq gx (/ (+ (car pt1) (car pt2)) 2))
	(setq gy (/ (+ (cadr pt1) (cadr pt2)) 2))
	(setq geo_c (list gx gy))|;
  
  ;(command "select" "wp" (foreach n l1(command n))"")
  ;(command "")
  ;(foreach n l1(command n))
  ; (setq a (car l1))
  ; (command a)
  (command "copybase" "0,0"  )
  (command "wp"  )
  (command(foreach n l1(command n) ""))
  (command "")
  (command "erase" "all" "")
  (command "pasteclip" "0,0" "") 
  (COMMAND "layer"  "u" "ME" "")
  
)
