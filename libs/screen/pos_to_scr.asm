	ifndef _POS_TO_SCR_ASM_
	define _POS_TO_SCR_ASM_

; вычисляем адрес по позиции знакоместа
; DE - D-x, E-y
SCREEN_POS_TO_SCR:
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

	endif
