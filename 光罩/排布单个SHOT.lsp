(defun c:ttt ()
  (setq x 474)
  (setq y 604)

  (setq c (getint "input column number to be delete:"))
  (setq r (getint "input row number to be delete:"))
  (command "erase" (list (* x c) (* y (- r))) "")
)