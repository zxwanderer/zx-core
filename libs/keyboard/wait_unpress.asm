		ifndef _KEYBOARD_WAIT_UNPRESS_ASM_
   	define _KEYBOARD_WAIT_UNPRESS_ASM_
	
KEYBOARD_WAIT_UNPRESS:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr nz, KEYBOARD_WAIT_UNPRESS
	ret

	endif
