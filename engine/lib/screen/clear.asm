
SCREEN_CLEAR:
    xor a : out (#fe), a
	ld hl,#4000, de,#4001, bc,#1800, (hl),l : ldir
	ld bc,#02ff, (hl),#47 : ldir
    ret
