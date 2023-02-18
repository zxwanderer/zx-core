	device zxspectrum48

SCREEN_ADDR equ #4000

	org #6000
start:

loop:
	; CALL SCREEN_CLEAR

	LD HL, #0000
	LD DE, #4000
	LD BC, #2000
	ldir

	LD A, 1
	CALL SCREEN_SET_COLORS 

	jp loop

	include "screen/clear.asm"
	include "screen/set_colors.asm"

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  