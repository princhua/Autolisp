(defun c:ttt ()
  (command "bedit" "die" 
   "line" '(0 0) '(-100 100) ""  
           (setq e1 (entlast))
  (setq e2 (entnext e1))           
  )
)