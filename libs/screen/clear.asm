; SCREEN_ADDR must be defined

SCREEN_CLEAR:
	LD HL,SCREEN_ADDR
	LD DE,SCREEN_ADDR+1
	LD BC,#1800
	LD (HL),L
	LDIR
	LD BC,#02ff
	LD (HL),#47
	LDIR
  RET