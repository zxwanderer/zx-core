	device zxspectrum128

INIT_VEC: equ #7D7D
SCREEN_ADDR equ #4000

	include "stack/push_pop_h.asm"
	include "im2/im2_h.asm"
	include "im2/vector_table_h.asm"

	org #6000
start:	di : ld sp, $-2

	xor a : out (#fe), a
	
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

	DO_POP_ALL_REGISTRY
	ei
	ret

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
  