
SCREEN_CLEAR:
	ld hl,SCREEN_ADDR, de,SCREEN_ADDR+1, bc,#1800, (hl),l : ldir
	ld bc,#02ff, (hl),#47 : ldir
    ret
