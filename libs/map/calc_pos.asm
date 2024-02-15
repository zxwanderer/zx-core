  ifndef _CALC_POS_ASM_
  define _CALC_POS_ASM_

; --------------------------------------------------------------------------------------
; переводим pos в указатель на ячейку в массиве карты
; Вход: 
;     DE - pos,  D - x, E - y
; Выход: 
;     HL - указатель
; --------------------------------------------------------------------------------------
MAP_CALC_PTR_BY_POS:
  LD HL, #0000
  PUSH DE
  LD C, D; запоминаем posX в C
  LD A, E
  CP 00
  JR Z, .no_mul; если ноль по Y то не будем прибавлять ничего
  LD B, E; кидаем posY в B - по B будет автодекрементный цикл
  LD D, 0
  LD E, TILE_MAP_SIZE_WIDTH
.mul_loop
  ADD HL,DE
  DJNZ .mul_loop
.no_mul
  POP DE
  LD E, D
  LD D, 0
  ADD HL, DE; в HL у нас
  LD DE, MAP_DATA
  ADD HL, DE
  RET

  endif
