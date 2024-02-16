  ifndef _CLEAR_ROWS_ASM_
  define _CLEAR_ROWS_ASM_

; Очистить N строчек экрана
; На входе:
;   в DE - начальный адрес экрана
;   в B - число строчек
SCREEN_CLEAR_ROWS:
.loop0
  LD A, #00 ; A у нас портится при вызове SCREEN_CALC_DOWN_POS, нужно восстановить 
  PUSH BC
  LD B, 8
  PUSH DE
.loop1:
  PUSH BC
  LD B, 32
  PUSH DE
.loop2:           // рисуем линию в 32 символа
  LD (DE), A
  INC E
  DJNZ .loop2
  POP DE
  INC D
  POP BC
  DJNZ .loop1
  POP DE
  CALL SCREEN_CALC_DOWN_POS
  POP BC
  DJNZ .loop0
  RET

    endif