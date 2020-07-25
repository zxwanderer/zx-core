; модуль отрисовываемого "окна"
MODULE View

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

; копируем тайлы из карты в массив отрисовки
; в HL указатель на индекс первого тайла карты
copy:
    LD IX, View.buffer
    LD B, scrHeight
copy_loop2:
    PUSH BC
    PUSH HL

    LD B,scrWidth
copy_loop1:
    PUSH BC

    LD A, (HL)
    LD (IX), A

    INC IX
    INC HL
    
    POP BC
    DJNZ copy_loop1

    POP HL
    LD BC, mapSize
    ADD HL, BC; прибавляем к указателю на начало тайлов ширину - сдвигаем указатель вниз на 1 тайл

    POP BC
    DJNZ copy_loop2
    RET

; отрисовываем тайлы на экране
draw:
    LD HL, View.buffer
    LD DE, SCREEN_ADDR ; current pos draw variable
    LD B, scrHeight
draw_loop2:
    PUSH BC
    PUSH DE

    LD B, scrWidth
draw_loop1:
    PUSH BC
    PUSH HL

    PUSH DE
    LD A,(HL)
    call TILE_INDEX_TO_PTR
    call SHOW_TILE_ON_SCREEN
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

; вход:
; D - x, E - y,
; A - dir
; look:
    ; CALL map.center_map
    ; CALL View.copy
    ; RET

; буфер тайлов
buffer:
    DUP scrHeight*scrWidth
    defb #01
    EDUP

ENDMODULE
