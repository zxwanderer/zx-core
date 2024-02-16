   ifndef _KEYBOARD_SCAN_AND_MAP_KEYS_ASM_
   define _KEYBOARD_SCAN_AND_MAP_KEYS_ASM_
	
	; принцип честно стырен из движка Wanderers by SamStyle
	; в HL указатель на таблицу клавиш вида [SCANCODE_XXX] [BUTTON_XXX], 0 - признак окончания таблицы
	; на выходе в KEYBOARD_PRESS_BUTTON код нажатой псевдокнопки джойстика
KEYBOARD_SCAN_AND_MAP_KEYS:
	XOR A
	LD (KEYBOARD_PRESS_BUTTON), A
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
	LD (KEYBOARD_PRESS_BUTTON), A
	RET

KEYBOARD_PRESS_BUTTON: defb 0

	endif
