; --------------------------------------------------------------------------------------
; Установить ячейку на карте
; Вход:
;   DE - pos,  D - x, E - y
;   A - номер спрайта
; --------------------------------------------------------------------------------------
MAP_SET_BY_POS:
  LD (.cur_spr), A
  CALL MAP_CALC_PTR_BY_POS
.cur_spr equ $+1
  LD (HL), #ff
  RET