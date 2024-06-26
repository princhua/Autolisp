
(defun right_MVP_section_drawing()
	(setq apt7 (list (- 25) (+ depth1 depth2)))
	(setq apt1 (list -25 depth2) apt2 (list -225 depth2) pad_c (list (- pad_dis2) 0))
	(setq pt1 '(-30 0) pt2 (polar pad_c 0 27.5) pt3 (polar pad_c (- pi) 27.5) pt4 (list (-(- pad_dis2)  trench_2) depth2) 
	pt5 (polar apt7 pi 800) 
	)
	(setq apt3 (polar pt1 (- pi (angtof ang2)) 50))
	(setq apt4 (polar pt2  (angtof ang2) 50))
	(setq apt5 (polar pt3 (- pi (angtof ang2)) 50))
	(setq apt6 (polar pt4 (- pi (angtof ang1)) 200))
	(command "line" apt1 apt2 "")
	(setq e1 (entlast))
	(command "line" apt7 pt5 "")
	(setq e2 (entlast))
	(command "pline" pt1 apt3 apt4 pt2 pt3 apt5 pt4 apt6 pt5 "")
	(setq e3 (entlast))
	(setq trpt1 (polar apt3 (angle apt3 pt1) 0.5))
	(setq trpt2 (polar apt3 pi 0.5))
	(setq trpt3 (polar apt4 (angle apt4 pt2) 0.5))
	(setq trpt4 (polar apt5 (angle apt5 pt3) 0.5))
	(setq trpt5 (polar apt5 (angle apt5 pt4) 0.5))
	(setq trpt6 (polar apt6 (angle apt6 pt4) 0.5))
	(setq trpt7 (polar apt6 (angle apt6 pt5) 0.5))
	(command "zoom" "e")
	(command "trim" "o" "q" "" apt1 trpt1 trpt2 trpt3 (polar pad_c (* pi 0.5) depth2) trpt4 trpt5 trpt7 trpt6 apt7 apt2 "")
  (command "pedit" "m" "c" pt1 pt5 "" "y" "j" ""  ""    )
  (setq e1 (entlast))
  (command "offset" 10  e1 apt3 "")
  (setq e2 (entlast))
  (command "offset" 4  e2 apt7 "")
  (setq e3 (entlast))
  (command "offset" 21  e3 apt7 "")
  (COMMAND "line" (polar pad_c (* pi 0.5) 10) (polar pad_c (* pi 1.5) 10) "")
  (setq e1 (entlast))
  (command "move" e1 "" pad_c (polar pad_c  pi 10) )
  (setq e1_terminal_pt (list (cadr(assoc 11(entget e1 ))) (caddr(assoc 11(entget e1 )))))
  (command "offset" 20 e1 pad_c "")
  (command "line" e1_terminal_pt (polar e1_terminal_pt 0 20) "")
  (setq pt6 (polar pt1  pi 795) pt7 (polar pt1 0 5) pt8 (polar pt7 ( * pi 1.5) cv) pt9 (polar pt8 pi 250))
  (command "line" pt2 pt7 pt8 pt9 (polar pt9 (* pi 0.5) cv)"" )
  (command "line"  pt6 (polar pt5 (* pi 0.5) 35) "" )
  (command "line"  pt3 pt6 ""  )
  (command "line" pt7 (polar pt7 (* pi 0.5) 150) "")
  (setq pad_apt1 (polar pad_c 0 (* pad_wid 0.5)) pad_apt2 (polar pad_c pi (* pad_wid 0.5)) pad_pt1 (polar pad_apt1 (* pi 1.5) 5) pad_pt2 (polar pad_apt2 (* pi 1.5) 5)
   cv_glue1 (polar pt7 (* pi 1.5) 2.5) cv_glue2 (polar cv_glue1 pi 250)
  )
  (command "line" cv_glue1 cv_glue2 "" )
  (command "pline" pad_apt1 pad_pt1 pad_pt2 pad_apt2 "")
  
  ;;;;;不含球截面画完
  ;(command "zoom" )
  ;;画球
  (setq ball_y (-(+(+(+ depth1 depth2)35)ball_hight)(* ball_dia 0.5)))
  (setq ball_center (list (- ball_dis2) ball_y))
  (command "circle" ball_center "d" ball_dia )
  (setq ball_apt1_x (-(-(- ball_dis2 (/ ball_dia 2))13)))
  (setq ball_apt1_y (+(+ depth1 depth2)35))
  (setq ball_apt1 (list ball_apt1_x ball_apt1_y))
  (command "line" ball_apt1 (polar ball_apt1 (/(* pi 4)3) 25) "")
  (setq ball_ent1 (entlast))
  (setq ball_apt2_x (-(+(+ ball_dis2 (/ ball_dia 2))13)))
  (setq ball_apt2_y (+(+ depth1 depth2)35))
  (setq ball_apt2 (list ball_apt2_x ball_apt2_y))
  (command "line" ball_apt2 (polar ball_apt2 (-(* pi 2)(/(* pi 1)3) ) 25) "")
  (setq ball_ent2 (entlast))
  (command "trim" "o" "q" "" (polar ball_apt1 (/(* pi 4)3) 25) (polar ball_apt2 (-(* pi 2)(/(* pi 1)3) )25)"")
  (setq RDL_line1 (list -45 (+ depth2 14)))
  (setq RDL_line2 (list (- (- ball_dis2) (+(/ ball_dia 2)25)) (+ (+ depth2 depth1) 14)))
  (command "line" RDL_line1 (polar RDL_line1 (* PI 1.5) 4) "")
  (command "line" RDL_line2 (polar RDL_line2 (* PI 1.5) 4) "")
  ;;已全部画完，进行裁剪
  ;;
  ;;PAD附近
  (setq trpad1 (polar pad_c (* pi 0.5) 12) trpad2 (polar pad_c (* pi 1.5) 8)
    trpad3 (polar pt3 (* pi 1.5) 2.5) trpad4 (polar pt2 (* pi 1.5) 2.5)
    trpad5 (polar pt3 (* pi 0.5) (+ depth2 24)) trpad6 (polar pt2 (* pi 0.5) (+ depth2 24))
    trpad7 (polar pad_c (* pi 0.5) 35)  
  )
  (command "zoom" pt8 apt6)
  (command "trim" "" "f" trpad1 trpad2 ""  "f" trpad5 trpad6 "" "r" trpad7 "" 
    trpad3 trpad4   "")
  ;;
  ;切割道附近
  
  (setq trcenter1 (polar pt1 (* pi 0.5) (+ depth2 35)) ;delete
   trcenter2 (polar RDL_line1 0 4) 
  )
  (command "zoom" pt2 apt7)
  (COMMAND "BREAKATPOINT" trcenter2 RDL_line1)
  (COMMAND "erase" trcenter2 (polar trcenter2 (* pi 0.5) 21) "")
  (command "extend" (polar pt3 (* pi 0.5) (+ depth2 35)) apt1 "" (polar pt3 (* pi 0.5) (+ depth2 35)) "")
  (command "trim" "" "f" (polar pt7 0 1) (polar apt7 0 1) "" apt7 "")
  
  
;;
  ;ball附近
  (command "zoom" cv_glue2 (polar pt5 (* pi 0.5) (* ball_dia 0.5)))
  (command "trim"  (polar ball_center (* pi 0.5) (* ball_dia 0.5)) (list(car ball_center) (+ (+ depth1 depth2) 14))
        "" (polar ball_center (* pi 1.5) (* ball_dia 0.5)) "")
  (command "trim"  (list(car ball_center) (+ (+ depth1 depth2) 35)) ball_ent1 ball_ent2
        "" (list(car ball_center) (+ (+ depth1 depth2) 35)) "")
  (command "trim" "o" "q" (polar RDL_line2 pi 10 ) (polar RDL_line2 (* pi 1.5)2 )"" (polar RDL_line2 pi 10 ) "")
  
)