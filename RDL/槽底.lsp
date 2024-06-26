(defun c:ttt()
	(setq p1(getpoint"choose PAD1:"))
	(setq dis1(getdist p1"choose PAD left dis1:"))
	(setq dis2(getdist p1"choose PAD right dis2:"))
	(setq apt1(polar p1 pi (-(* 0.5 dis1) 20)))
	(setq apt2(polar p1 0 (-(* 0.5 dis2) 20)))
	(setq pt1(polar apt1 (* pi 1.5) 192))
	(setq pt2(polar apt2 (* pi 1.5) 192))
	(setq pt3(polar apt1 (* pi 0.5) 117))
	(setq pt4(polar apt2 (* pi 0.5) 117))


	(setq osm (getvar "osmode"))
	(setvar "osmode" 0)
	(command "pline" pt1 pt3 pt4 pt2 "")
	(setvar "osmode" osm)
	(princ)
)