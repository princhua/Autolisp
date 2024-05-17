(defun c:ttt ()
	(setq dlg_id(load_dialog "C:\\Users\\chenggh\\Desktop\\lisp\\截面图\\截面图DCL"))
	(if(< dlg_id 0) (exit))
	(if (not(new_dialog "section" dlg_id))(exit))
	(setq origin '(0 0))
	

	(setq depth1 90 depth2 30 trench_1 70 trench_2 70 pad_dis1 150 pad_dis2 150 ang1 60 ang2 65
   pad_wid 75 ball_dia 250 ball_dis1 500 ball_dis2 500 ball_hight 120
  )
	(setdata)
	(action_tile "accept" "(getdata)(done_dialog 1)")
	(action_tile "cancel" "(done_dialog 0)")
	(setq std (start_dialog))
	(unload_dialog dlg_id)
	(if (= std 1)
		(progn
    (setq osm (getvar "osmode"))
    (setvar "osmode" 0)
    (setvar "cmdecho" 0)
			(command "zoom" "w" '(-50 -50) '(50 50) "") (right_MVP_section_drawing) (left_MVP_section_drawing)
    (lable_3)
    (setvar "osmode" osm)
		)
	)
	(command "zoom" "e")
	(princ)
)


(defun getdata()
	(setq depth1(atof(get_tile "depth1")))
	(setq depth2(atof(get_tile "depth2")))
	(setq st(atof(get_tile "st")))
	(setq cv(atof(get_tile "cv")))
	(setq trench_1(atof(get_tile "trench_dis1")))
	(setq trench_2(atof(get_tile "trench_dis2")))
	(setq pad_dis1(atof(get_tile "pad_dis1")))
	(setq pad_dis2(atof(get_tile "pad_dis2")))
	(setq ang1 (get_tile "ang1"))
	(setq ang2 (get_tile "ang2"))
	(setq ball_dis1 (atof(get_tile "ball_dis1")))
	(setq ball_dis2 (atof(get_tile "ball_dis2")))
  
	(setq pad_wid(atof(get_tile "width")))
	(setq ball_dia(atof(get_tile "ball_dia")))
  (setq ball_hight(atof(get_tile "ball_hight")))
  (if (= cv 0)(setq cv 31) (if (= cv 1)(setq cv 41)))
  (if (= st 0)(setq st mvp) (if (= cv 1)(setq st ut)))
  ;DCL POP LIST 数据获取
)

(defun setdata()
	(set_tile "depth1"(rtos depth1 2 2))
	(set_tile "depth2"(rtos depth2 2 2))
	(set_tile "trench_dis1"(rtos trench_1 2 2))
	(set_tile "trench_dis2"(rtos trench_2 2 2))
	(set_tile "pad_dis1"(rtos pad_dis1 2 2))
	(set_tile "pad_dis2"(rtos pad_dis2 2 2))
	(set_tile "ang1"(rtos ang1 2 2))
	(set_tile "ang2"(rtos ang2 2 2))
	(set_tile "width"(rtos pad_wid 2 2))
	(set_tile "ball_dia"(rtos ball_dia 2 2))
	(set_tile "ball_dis1"(rtos ball_dis1 2 2))
	(set_tile "ball_dis2"(rtos ball_dis2 2 2))
  (set_tile "ball_hight"(rtos ball_hight 2 2))
  
)

(defun left_MVP_section_drawing()
  (command "layer" "m" 0 "")
	(setq apt7 (list (- 25) (+ depth1 depth2)))
	(setq apt1 (list -25 depth2) apt2 (list -225 depth2) pad_c (list (- pad_dis1) 0))
	(setq pt1 '(-30 0) pt2 (polar pad_c 0 27.5) pt3 (polar pad_c (- pi) 27.5) pt4 (list (-(- pad_dis1)  trench_1) depth2) 
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
	(command "zoom" "w" pt7 pt5)
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
  (setq ball_center (list (- ball_dis1) ball_y))
  (command "circle" ball_center "d" ball_dia )
  (setq ball_apt1_x (-(-(- ball_dis1 (/ ball_dia 2))13)))
  (setq ball_apt1_y (+(+ depth1 depth2)35))
  (setq ball_apt1 (list ball_apt1_x ball_apt1_y))
  (command "line" ball_apt1 (polar ball_apt1 (/(* pi 4)3) 25) "")
  (setq ball_ent1 (entlast))
  (setq ball_apt2_x (-(+(+ ball_dis1 (/ ball_dia 2))13)))
  (setq ball_apt2_y (+(+ depth1 depth2)35))
  (setq ball_apt2 (list ball_apt2_x ball_apt2_y))
  (command "line" ball_apt2 (polar ball_apt2 (-(* pi 2)(/(* pi 1)3) ) 25) "")
  (setq ball_ent2 (entlast))
  (command "trim" "o" "q" "" (polar ball_apt1 (/(* pi 4)3) 25) (polar ball_apt2 (-(* pi 2)(/(* pi 1)3) )25)"")
  (setq RDL_line1 (list -45 (+ depth2 14)))
  (setq RDL_line2 (list (- (- ball_dis1) (+(/ ball_dia 2)25)) (+ (+ depth2 depth1) 14)))
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
  (command "zoom" (polar cv_glue2 (* pi 1.5) 200) (polar pt5 (* pi 0.5) (* ball_dia 0.5)))
  (command "trim"  (polar ball_center (* pi 0.5) (* ball_dia 0.5)) (list(car ball_center) (+ (+ depth1 depth2) 14))
        "" (polar ball_center (* pi 1.5) (* ball_dia 0.5)) "")
  (command "trim"  (list(car ball_center) (+ (+ depth1 depth2) 35)) ball_ent1 ball_ent2
        "" (list(car ball_center) (+ (+ depth1 depth2) 35)) "")
  (command "trim" "o" "q" (polar RDL_line2 pi 10 ) (polar RDL_line2 (* pi 1.5)2 )"" (polar RDL_line2 pi 10 ) "")
  (left_fill)
  (left_lable)
  (lable_2)
)
  
  
  
  ;;;左面画完
  
  
  
  
  ;;;画右面

  (defun right_MVP_section_drawing()
    (command "layer" "m" "0" "")
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
  
  ;;;;不含球截面画完
  
  ;画球
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
  (command "zoom" (polar cv_glue2 (* pi 1.5) 200)(polar pt5 (* pi 0.5) (* ball_dia 0.5)))
  (command "trim"  (polar ball_center (* pi 0.5) (* ball_dia 0.5)) (list(car ball_center) (+ (+ depth1 depth2) 14))
        "" (polar ball_center (* pi 1.5) (* ball_dia 0.5)) "")
  (command "trim"  (list(car ball_center) (+ (+ depth1 depth2) 35)) ball_ent1 ball_ent2
        "" (list(car ball_center) (+ (+ depth1 depth2) 35)) "")
  (command "trim" "o" "q" (polar RDL_line2 pi 10 ) (polar RDL_line2 (* pi 1.5)2 )"" (polar RDL_line2 pi 10 ) "")
    
    
    
    

    (right_fill)
    (right_lable)
    (lable_1)
    
  ;镜像到右面
  
  (command "zoom" (polar pt8 (* pi 1.75) 50) (polar pt5 (* pi 0.5) 500))
  (command "mirror" "c" (polar pt8 (* pi 1.75) 50) (polar pt5 (* pi 0.5) 500) "" '(0 0) '(0 1) "y")
  
)

;标注和填充
(defun right_lable()
  (command "layer" "m" "lable_fill" "")
  (setq la1 (list (+(-(car pad_c)trench_2)10) -200) la2 (list (-(-(car pad_c)trench_2)10) 360)
  la3 '(-22.5 -120) la4 '(-27.5 210)  
  )
  (command "zoom" la2 (polar la3 (* pi -1.5) 100))
  (command "rectang" la1 la2)
  (setq la_e1 (entlast))
  (command "rectang" la3 la4)
  (setq la_e2 (entlast))
;;获取孔位置坐标
  (setq ss(ssget (polar pt2 (angtof ang2) 5)))
  (setq la_e3(ssname ss 0))
  (setq la_e3(entget la_e3))    
  (setq point_list (mapcar 'cdr (vl-remove-if-not' (lambda (x) (=(car x)10)) la_e3)))
  (setq pt (nth 2 point_list))
  (setq la5 (list (+(car pt)7.5) -125))
  (setq la6 (list (-(car pt)7.5) 125))
  (command "rectang" la5 la6)
  (setq e3 (entlast ))
  (command "mirror" e3 "" pad_c (polar pad_c (* pi 0.5) 1) "n")
  (setq e4 (entlast ))


)

(defun left_lable()
  (command "layer" "m" "lable_fill" "")
   (setq la1 (list (+(-(car pad_c)trench_1)10) -200) la2 (list (-(-(car pad_c)trench_1)10) 360)
  la3 '(-22.5 -120) la4 '(-27.5 210)  
  )
  (command "rectang" la1 la2)
  (command "rectang" la3 la4)

  
)
  ;;填充 
    ;PAD附近
(defun right_fill()
    (command "zoom" pt8 apt6)
  (command "-hatch" "p" "solid"  "")
  (command "-hatch" "co" 1  (polar pad_pt1 (* pi 0.75) 2) (polar pad_pt2 (* pi 0.25) 2) "")
  (command "-hatch" "co" 2 (polar cv_glue1 (* pi 0.75) 2) (polar cv_glue2 (* pi 0.25) 2) "")
  (command "-hatch" "co" 3 (polar pt8 (* pi 0.75) 2) "")
  (command "-hatch" "co" 8 (polar pt2 (* pi 0.1) 2) (polar pt3 (* pi 0.9) 2) "") 
    (command "-hatch" "co" 102 (polar pt2 (* pi 0.75) 2) (polar pt3 (* pi 0.25) 2) "") 
    (command "-hatch" "co" 30 pad_c "") 
    (command "-hatch" "co" 106 (polar pad_c (* pi 0.5) 50 ) "")
    
    ;球附近
  (command "zoom" RDL_line2 (polar RDL_line2(* pi 0.75) 100))
    (command "-hatch" "co" 106 (polar RDL_line2 (* pi 0.75) 2) "")
)

(defun left_fill()
    (command "zoom" pt8 apt6)
  (command "-hatch" "p" "solid"  "")
  (command "-hatch" "co" 1  (polar pad_pt1 (* pi 0.75) 2) (polar pad_pt2 (* pi 0.25) 2) "")
  (command "-hatch" "co" 2 (polar cv_glue1 (* pi 0.75) 2) (polar cv_glue2 (* pi 0.25) 2) "")
  (command "-hatch" "co" 3 (polar pt8 (* pi 0.75) 2) "")
  (command "-hatch" "co" 8 (polar pt2 (* pi 0.1) 2) (polar pt3 (* pi 0.9) 2) "") 
    (command "-hatch" "co" 102 (polar pt2 (* pi 0.75) 2) (polar pt3 (* pi 0.25) 2) "") 
    (command "-hatch" "co" 30 pad_c "") 
    (command "-hatch" "co" 106 (polar pad_c (* pi 0.5) 50 ) "")
    
    ;球附近
  (command "zoom" RDL_line2 (polar RDL_line2(* pi 0.75) 100))
    (command "-hatch" "co" 106 (polar RDL_line2 (* pi 0.75) 2) "")
)
  
;;标注
(defun lable_1 ()
  (command "layer" "m" "lable_fill" "")
  (command "layer" "off" 0 "")
   (command "zoom" '(0 -250) '(-500 500))
  (command "-hatch" "p" "ansi31" 1 0  "co" 152 (polar la1 (* pi 0.75 ) 2) "")
  (command "-hatch" "co" 1 "" (polar la3 (* pi 0.75 )2) "")
  (command "-hatch" "co" 214 "" "s" e3 e4 "" "")
    (command "layer" "on" 0 "")
)

(defun lable_2 ()
  (command "layer" "m" "lable_fill" "")
  (command "layer" "off" 0 "")
   (command "zoom" '(0 -250) '(-500 500))
  (command "-hatch" "p" "ansi31" 1 0  "co" 152 (polar la1 (* pi 0.75 ) 2) "")
  (command "-hatch" "co" 1 "" (polar la3 (* pi 0.75 )2) "")

    (command "layer" "on" 0 "")
)

(defun lable_3()
  (command "layer" "m" "lable_fill" "")
  (setvar "dimasz" 20 )
  (setvar "dimtxt" 20)
  (setq left_t (list (-(- pad_dis1)trench_1) 360) right_t(list (+ pad_dis2 trench_2) 360))
  (setq left_v  (list (- (car pt)) 125) right_v (list (+ pad_dis2(- pad_dis2 (-(car pt)))) 125))
  (command "dimlinear" left_t right_t  "t" "Etch-2 Bottom Width(<>%%p20μm)" '(0 410))
  (command "dimlinear" left_v right_v  "t" "Etch-3 Top Width\n(<>%%p15μm)" (list pad_dis2 175))
  (command "dimlinear" '(25 210) '(-25 210)  "t" "Dicing(<>%%p5μm)" (list 0 260))
)


	
