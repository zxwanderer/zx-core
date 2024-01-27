	device zxspectrum128

INIT_VEC: equ #7D7D
SCREEN_ADDR equ #4000

	include "stack/push_pop_h.asm"
	include "im2/im2_h.asm"
	include "im2/vector_table_h.asm"

	org #6000
start:
	di
	ld sp, $-2

	xor a
	out (#fe), a
	
	CALL SCREEN_CLEAR

	SetIM2 interruptTab, INIT_VEC

	; main loop
1	ld a,2 : out (#fe), a
	inc a :  out (#fe), a

	jr 1b

	include "screen/clear.asm"

// ------------- interrupt tabs
    DefineVectorTable interruptTab

// ------------- im2 routines
	ASSERT $ < INIT_VEC
	ORG INIT_VEC
interr:
	di
	DO_PUSH_ALL_REGISTRY

	; ORG #FEFF 
; VECTOR:
	; DEFW ENTRY 

GETKEY:
	IN A,(#EF) ; опрос джойстика
	LD HL,#FFFF

NOBIT:
	RRCA
	INC HL ; поиск справа-налево единичного
	JR NC, NOBIT ; бита
	LD A, L
	CP 5 ; если не нажата ни одна из кнопок
	JP Z, EXIT
	ADD HL, HL
	LD DE, TABLE ; в противном случае опрос: клавиатуры
	ADD HL, DE ; имитируется занесением в DE
	LD E, (HL) ; значения из таблицы TABLE
	INC HL
	LD D, (HL)

	DO_POP_ALL_REGISTRY
	ei
	ret

EXIT:
	di
	halt

TABLE:
	DEFW #2713 ; значение DE для кнопки "вправо" 
	DEFW #2704 ; значение DE для кнопки "влево"
	DEFW #2703 ; значение DE для кнопки "вниз"
	DEFW #270B ; значение DE для кнопки "вверх"
	DEFW #2723 ; значение DE для кнопки "огонь"

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
  