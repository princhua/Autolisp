(defun c:ttt ( )
	(setq file(getfiled "choose file" "C:\\Users\\chenggh\\Desktop\\PAD坐标" "txt" 2))
	(setq filed(open file "r"))
	(setq flist '() )
	(setq filedata(read-line filed))
	(while filedata
		(setq flist(cons filedata flist))
		(setq filedata(read-line filed))
	)
	(close filed)
	(setq flist(reverse flist))
	(foreach pt flist
		(command "insert" "PAD" pt 1 1 0))
	(princ)
)
	
