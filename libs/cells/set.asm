; --------------------------------------------------------------------------------------
; Установить ячейку на карте
; Вход:
;   DE - pos,  D - x, E - y
;   A - номер спрайта
; --------------------------------------------------------------------------------------
CELLS_SET:
  LD (.cur_spr), A
  CALL CELLS_CALC_POS
.cur_spr equ $+1
  LD (HL), #ff
  RET