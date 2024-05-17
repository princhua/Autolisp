(defun c:RDL()
	(setq p1(getpoint"choose PAD:"))
	(setq p2(getpoint"choose UBM:"))
	(cond 
		((< (car p1) (car p2))(setq ang (* 0.75 pi)))
		((> (car p1) (car p2))(setq ang (* 0.25 pi)))
	)
	(setq p3(polar p2 ang 800))
	(setq p4(polar p1 (* 1.5 pi) (-(cadr p1)(cadr p2))))
	(setq osm (getvar "osmode"))
	(setvar "osmode" 0)
	(command "line" p1 p4 "")
	(setq e1(entlast))
	(command "line" p2 p3 "")
	(setq e2(entlast))
	(command "trim" e1 e2 "" p4 p3 "")
	(setvar "osmode" osm)
	(princ)
)