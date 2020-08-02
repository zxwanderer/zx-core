MACRO SRL_A_AND_CALL_HL
  mLDE
  SRL A
  JR NC, .exit
  PUSH AF
  PUSH HL
  EX DE, HL
  CALL callHL
  POP HL
  POP AF
.exit  
ENDM

callHL:  JP (HL)

; HL - указатель на таблицу-обработчиков клавиш
; A - нажатые клавиши
KEYBOARD_PROCESS_BUTTONS:
c_up:
  SRL_A_AND_CALL_HL
c_down:
  SRL_A_AND_CALL_HL
c_left:
  SRL_A_AND_CALL_HL
c_right:
  SRL_A_AND_CALL_HL
c_fire:
  SRL_A_AND_CALL_HL
c_exit:
  RET
