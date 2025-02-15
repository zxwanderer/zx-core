  ifndef _TEXT68_ASM_
  define _TEXT68_ASM_

  MODULE Text68

; переводим при печати на одну строчку вниз
; внутренняя служебная процедура
_make_down
  LD A, E
  AND 11100000b
  LD E, A
  call SCREEN_CALC_DOWN_POS
  LD C,7
  INC HL
  JP LOOP

; DE - screen pointer
; HL - text pointer
print_at:
  LD C, 7
LOOP:
;-----
  LD A,(HL)
  OR A
  JP Z, EXIT
  CP 13
  JP Z, _make_down

  PUSH HL
  CALL PRINT_68

; ----- CALC_CE ----
  LD A,C
  SUB 6
  JR NC, $+5;calc_ce_end
  INC E
  AND 7
calc_ce_end: 
  LD C,A

  LD A, E
  AND 31
  CP 31
  JR NZ, no_next_pos

  LD A, E
  AND 11100000b
  LD E, A
  call SCREEN_CALC_DOWN_POS
  LD C,7
no_next_pos:

;------
  POP HL
  INC HL
  JR LOOP
EXIT:

  ;LD DE, #4000
  ;LD HL, TEXT

  RET

PRINT_68:
  PUSH DE
  LD L,A
  LD B,C
  LD A,#80 ; ( 10000000 )
  RRCA
  DJNZ $-1
  LD (PRN+1),A
  LD H, HIGH p68_font
  LD B,8
PRGO:
  PUSH HL
  LD L,(HL)
PRN:
  LD H,1
PR1:
  ADD HL,HL
  ADD HL,HL
  JR NC,PR1
  LD A,(DE)
  OR H
  LD (DE),A
  ; out(#fe),a
  ; halt
  INC E
  LD A,L
  LD (DE),A
  ; out(#fe),a
  DEC E
  INC D
  POP HL
  INC H
  DJNZ PRGO
  POP DE
  RET

  ENDMODULE

  endif
