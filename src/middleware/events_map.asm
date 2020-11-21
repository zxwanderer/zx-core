MODULE EventsMap

init:
  LD HL, #C000
  LD DE, #C001
  LD BC, #3FFF
  LD (HL),0
  LDIR
  RET

lookDir:
  RET

ENDMODULE
