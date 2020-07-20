; перемещаемся вниз на одно знакоместо
; Вход: DE- экранный адрес
; Выход: DE - экранный адрес
SCREEN_CALC_DOWN_POS:
	LD A,E
	ADD A,#20 
	LD E,A 
	RET NC 
	LD A,D 
	ADD A,8 
	LD D,A 
	RET
