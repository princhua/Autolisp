(defun c:namettt ( )
	(setq file(getfiled "choose file" "C:\\Users\\chenggh\\Desktop\\RDL\\PAD坐标" "txt" 2))
	(setq filed(open file "r"))
	(setq flist '() )
	(setq filedata(read-line filed))
	(while filedata
		(setq flist(cons filedata flist))
		(setq filedata(read-line filed))
	)
	(close filed)
	(setq flist(reverse flist))

	(setq file_PIN_name (getfiled "choose file" "C:\\Users\\chenggh\\Desktop\\RDL\\name" "txt" 2))
	(setq file_PIN_named (open file_PIN_name "r"))
	(setq name_list '() )
	(setq name_data(read-line file_PIN_named))
	(while name_data
		(setq name_list(cons name_data name_list))
		(setq name_data(read-line file_PIN_named))
	)
	(close filed)
	(setq name_list(reverse name_list))
	(setq n 0)
	(repeat(length name_list)
		
		(setq pt (nth n flist))
		(setq name (nth n name_list))
			
		(command "text"  pt 90 90 name)
		(setq n (1+ n))
	)
	(princ)
)