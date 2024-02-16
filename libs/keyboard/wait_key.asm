		ifndef _KEYBOARD_WAIT_KEY_PRESS_ASM_
   	define _KEYBOARD_WAIT_KEY_PRESS_ASM_
	
KEYBOARD_WAIT_KEY_PRESS:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr z, KEYBOARD_WAIT_KEY_PRESS
	ret

	endif
