
SCREEN_SET_COLORS:
  LD HL,SCREEN_ATTR_ADDR
  LD (HL),A
  LD DE,SCREEN_ATTR_ADDR+1
  LD BC,768
  LDIR
  RET