; процедура пересчета адреса в экранной области
; в адрес в области атрибутов
; Вход: DE - адрес в экранной области
; Выход: DE - адрес в области атрибутов
SCREEN_ADDR_TO_ATTR:
	LD A,D
	AND #18
	RRCA
	RRCA
	RRCA
	ADD A,SCREEN_ATTR_ADDR/#100
	LD D,A
	RET
