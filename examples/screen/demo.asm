	device zxspectrum48

SCREEN_ADDR equ #4000
SCREEN_ATTR_ADDR equ SCREEN_ADDR + #1800

	org #6000
start:
	CALL Screen.SCREEN_CLEAR

loop:
	; CALL Keypress.KEYBOARD_WAIT_KEY_PRESS
	; CALL Keypress.KEYBOARD_WAIT_UNPRESS
	
	LD HL, #0000
	LD DE, #4000
	LD BC, #2000
	LDIR

	CALL Keypress.KEYBOARD_WAIT_KEY_PRESS
	CALL Keypress.KEYBOARD_WAIT_UNPRESS

	LD A, 1
	CALL Screen.SCREEN_SET_COLORS

	CALL Keypress.KEYBOARD_WAIT_KEY_PRESS
	CALL Keypress.KEYBOARD_WAIT_UNPRESS

	jp loop

	MODULE Screen
		include "screen/clear.asm"
		include "screen/set_colors.asm"
	ENDMODULE

	MODULE Keypress
		include "keyboard/wait_key.asm"
		include "keyboard/wait_unkey.asm"
	ENDMODULE

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  