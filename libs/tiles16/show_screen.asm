; по текущему адресу тайла на экране получаем адрес тайла справа от него
; в DE - адрес тайла на экране
; на выходе в DE адрес следующего справа тайла на экране
 MACRO NEXT_TILE_POS_RIGHT
  INC E
  INC E
 ENDM

 MACRO NEXT_TITLE_POS_DOWN
  LD A, #20+#20 ; 64
  ADD A,E
  LD E,A
  JR NC, .next_tile_pos_down_exit
  ; переполнение - значит мы перешли на другую треть, прибавляем 8 к D
  LD E,00
  LD A, #8
  ADD A,D
  LD D,A
.next_tile_pos_down_exit:
  ;LD E,A
  ; если есть переполнение - значит мы вышли за границу трети экрана, смотрим куда попали
 ENDM

; отрисовываем тайлы на экране
TILE16_SHOW_SCREEN:
  LD HL, VIEW_BUFFER
  LD DE, SCREEN_ADDR ; current pos draw variable
  LD B, TILE_SCR_HEIGTH
draw_loop2:
  PUSH BC
  PUSH DE

  LD B, TILE_SCR_WIDTH
draw_loop1:
  PUSH BC
  PUSH HL

  PUSH DE
  LD A,(HL)
  call TILE16_INDEX_TO_PTR
  call TILE16_SHOW
  POP DE
  NEXT_TILE_POS_RIGHT

  POP HL
  INC HL
  POP BC
  DJNZ draw_loop1   

  POP DE
  NEXT_TITLE_POS_DOWN

  POP BC
  DJNZ draw_loop2

  RET
