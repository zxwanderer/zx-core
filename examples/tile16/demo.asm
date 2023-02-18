	device zxspectrum48

TILE_SET equ #0000
SCREEN_ADDR equ #4000
SCREEN_ATTR_ADDR equ SCREEN_ADDR + #1800

	org #6000
start:

	LD HL, #0000
loop:
	PUSH HL
	LD DE, #4000
	CALL TILE_16_SHOW
	POP HL
	INC	HL
	jp loop

	include "screen/addr_to_attr.asm"
	
	include "tiles16/show.asm"
	include "tiles16/index_to_ptr.asm"
	

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  