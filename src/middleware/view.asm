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

; На входе координаты ячейки которую хотим поместить в центр вывода на экране
; На выходе координаты левого верхнего угла обзорного окна на карте
; Вход: DE - pos,  D - x, E - y
; Выход: DE - pos,  D - x, E - y

center_map:
centr_X:
  LD A,D; проверяем X на минимальность
  SUB scrWidthHalf; вычитаем из A половину ширины экрана
  JR NC, centr_X_max
  LD D, #00; обнуляем X
  JR centr_Y
centr_X_max:
  CP scrWindowMaxX
  JR C,set_x
  LD D, scrWindowMaxX-1
  JR centr_Y
set_x:
  LD D, A
centr_Y:
  LD A, E; проверяем X на минимальность
  SUB scrHeightHalf
  JR NC, centr_Y_max
  LD E, #00; обнуляем X
  JP center_map_end
centr_Y_max:
  CP scrWindowMaxY
  JR C,set_y
  LD E, scrWindowMaxY-1
  JP center_map_end
set_y:
  LD E, A
center_map_end:
  RET

; переводим pos в указатель на ячейку в массиве карты
; Вход: DE - pos,  D - x, E - y
; Выход: HL - указатель
calc_pos:
  LD HL, #0000
  PUSH DE
  LD C,D; запоминаем posX в C
  LD A,E
  CP 00
  JR Z, no_mul; если ноль по Y то не будем прибавлять ничего
  LD B,E; кидаем posY в B - по B будет автодекрементный цикл
  LD D,0
  LD E, mapSize
mul_loop
  ADD HL,DE
  DJNZ mul_loop
no_mul
  POP DE
  LD E,D
  LD D,0
  ADD HL,DE; в HL у нас
  LD DE, MAP_SET
  ADD HL, DE
  RET

; вход:
; D - x, E - y,
lookAt:
    CALL View.center_map
    CALL View.calc_pos
    CALL View.copy
    RET

; буфер тайлов
buffer:
    DUP scrHeight*scrWidth
    defb #01
    EDUP

ENDMODULE
