; Получить примерную длительность нажатия клавиши
; На выходе:
;   DE - условная длительность нажатия, максимальное значение #FFFF
KEYBOARD_WAIT_UNPRESS_LONG:
  LD DE, #0000

.wait_uppress:	
  INC DE
  LD A, D
  CP #FF
  RET Z

  xor a
  in a,(0xfe)
  cpl
  and 31
  jr nz, .wait_uppress
  ret
