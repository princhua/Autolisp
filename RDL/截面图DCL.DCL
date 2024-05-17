section:dialog{
	label="figure_4";
	:text{
		label="Please carefully check data                   Unit:(um)";
		alignment=left;
		color=1;
		}
	spacer_1;
	:boxed_row{
		label="Package Strcuture";
		:popup_list{
			label="Structure Type:";
			edit_width=6;
			list="MVP\nUT";
			value=0;
			key="st";
		}
		:popup_list{
			label="CV Thinckness(um):";
			edit_width=6;
			list="31\n41";
			value=0;
			key="cv";
		}
	}
	spacer_1;
	:boxed_row{
		label="Angle";
		:edit_box{
		label="Trench angle:";
		edit_width=6;
		key=ang1;
		}
		:edit_box{
		label="Via angle:";
		edit_width=6;
		key=ang2;
		}
	}
	spacer_1;
	:boxed_row{
		label="Depth";
		:edit_box{
		label="Trench depth:";
		edit_width=6;
		key=depth1;
		}
		:edit_box{
		label="Via depth:";
		edit_width=6;
		key=depth2;
		}
	}
	spacer_1;
	:boxed_row{
		label="Ball and PAD size";
		:edit_box{
		label="Ball diameter:";
		edit_width=6;
		key=ball_dia;
		}
		:edit_box{
		label="PAD width:";
		edit_width=6;
		key=width;
		}
	}
	spacer_1;
	:boxed_column{
		label="Left distance data";
		:edit_box{
		label="Left PAD center to center-line:";
		edit_width=6;
		key=pad_dis1;
		}
		:edit_box{
		label="Left ball center to center-line:";
		edit_width=6;
		key=ball_dis1;
		}
		:edit_box{
		label="Left trench to PAD center distance:";
		edit_width=6;
		key=trench_dis1;
		}

	}
	spacer_1;
	:boxed_column{
		label="Right distance data";
		:edit_box{
		label="Right PAD center to center-line:";
		edit_width=6;
		key=pad_dis2;
		}
		:edit_box{
		label="Right ball center to center-line:";
		edit_width=6;
		key=ball_dis2;
		}
		:edit_box{
		label="Right trench to PAD center distance:";
		edit_width=6;
		key=trench_dis2;
		}
	}

	
	
	spacer_1;
	ok_cancel;
}