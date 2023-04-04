
; вычисляем адрес по позиции знакоместа
; DE - D-x, E-y
POS_TO_SCR:
	LD A,E
	AND  7
	RRCA
	RRCA
	RRCA
	ADD  A,D
	LD   D,E
	LD   E,A
	LD   A,D
	AND  #18
	OR   high SCREEN_ADDR
	LD   D,A
	RET
