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

; программа показывает на экране карту тайлов
; в HL - адрес первого тайла на карте
show_tile_map:
  LD DE, SCREEN_ADDR ; current pos draw variable
  LD B, scrHeight
show_tile_map_loop2: ; цикл по столбцам
  PUSH BC
  PUSH HL; ---- запоминаем все в стек
  PUSH DE

; ------------ рисуем строку тайлов -------------
  LD B, scrWidth
show_tile_map_loop1: ; цикл по строкам
  PUSH BC
  PUSH HL; ---- запоминаем все в стек
  PUSH DE

  LD A,(HL)
  call SPRITE_INDEX_TO_PTR_16
  call SPRITE_SHOW_TILE_16

  POP DE; ---- снимаем все со стека
  NEXT_TILE_POS_RIGHT

  POP HL
  INC HL; сдвигаем указатель на ячейку карты влево
  POP BC
  DJNZ show_tile_map_loop1
; ------------ закончили рисовать строку тайлов -------------

  POP DE
  NEXT_TITLE_POS_DOWN
  POP HL; ---- снимаем все со стека
  LD BC, mapSize
  ADD HL, BC; прибавляем к указателю на начало тайлов ширину - сдвигаем указатель вниз на 1 тайл
  POP BC
  DJNZ show_tile_map_loop2
  RET

 