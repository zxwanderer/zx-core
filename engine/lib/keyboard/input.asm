MODULE Input

; статус нажатых кнопок
pressButtons: defb 0

waitKey:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr z,waitKey
	ret

waitNoKey:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr nz,waitNoKey
	ret

	; принцип честно стырен из движка Wanderers by SamStyle
	; в HL указатель на таблицу клавиш вида [KEY_XXX] [BUTTON_XXX]
scanKeys:
	XOR A
	LD (Input.pressButtons), A
scanKeys_loop:
	LD A,(HL) ;//  загружаем первый байт
	AND A  ;проверяем на 0
	RET Z ; возвращаем если 0
	INC HL ; увеличиваем HL
	IN A,(0xFE) ; читаем значение
	AND (HL) ; сравниваем со вторым байтом
	INC HL
	LD A, (HL); запомнили код
	INC HL
	JR NZ, scanKeys_loop
	LD (Input.pressButtons), A
	RET

ENDMODULE
