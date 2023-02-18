KEYBOARD_WAIT_KEY_PRESS:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr z, KEYBOARD_WAIT_KEY_PRESS
	ret
