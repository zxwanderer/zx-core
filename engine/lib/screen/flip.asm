
SCREEN_FLIP:
	ld a, (cur_scr+1)
	xor %00001000
	ld (cur_scr+1), a
	ret
