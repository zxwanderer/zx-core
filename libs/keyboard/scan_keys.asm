	; принцип честно стырен из движка Wanderers by SamStyle
	; в HL указатель на таблицу клавиш вида [SCANCODE_XXX] [##, ##], 0 - признак окончания таблицы
	; на выходе в DE указатель на процедуру #### или флаг переноса ноль (JP NZ, call_script_call..)
KEYBOARD_SCAN_KEYS:
	ld a,(HL) ;//  загружаем первый байт
	and a  ;проверяем на 0
	ret z ; возвращаем если 0
	inc hl ; увеличиваем HL
	in a,(0xfe) ; читаем значение
	and (hl) ; сравниваем со вторым байтом
	inc hl   ; увеличиваем указатель
	ld e,(hl)
	inc hl
	ld d,(hl) ; запоминаем в DE указатель на процедуру
	inc hl    ; увеличиваем HL
	jr nz,KEYBOARD_SCAN_KEYS
	or 2
	ret
