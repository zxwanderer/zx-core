	device zxspectrum128

INT_TABLE equ $BD00
INIT_VEC equ #BEBE

	include "stack/push_pop_h.asm"
	include "im2/im2_h.asm"
	
	org #6000
start:	
	di 

	ld hl, music_data
  call MUSIC_INIT

	IM2_INIT INT_TABLE, INIT_VEC
	ei

loop:
	ld a, r
	out (#fe), a
	jr loop

	include "music.asm"

// ------------- interrupt tabs
	IM2_ORG_VECTOR_TABLE INT_TABLE

// ------------- im2 routines
	ASSERT $ < INIT_VEC
	ORG INIT_VEC
interr:	
	di
	DO_PUSH_ALL_REGISTRY
	
	ld a, 1
	out (#fe), a
	
	call MUSIC_PLAY

	ld a, 2
	out (#fe), a

	DO_POP_ALL_REGISTRY
	ei
	ret

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  