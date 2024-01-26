	device zxspectrum48

SCREEN_ADDR equ #4000
SCREEN_ATTR_ADDR equ SCREEN_ADDR + #1800

	org #6000
start:

	LD DE, #4000
	LD HL, message
	CALL Text68.print_at

loop:
	jp loop
		
	include "text/text68.asm"

	include "screen/calc_down_pos.asm"


message: db 'Hello world!', 0

	align	256
p68_font:
	incbin "Font57_revert.fnt"

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  