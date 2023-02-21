; На входе координаты ячейки которую хотим поместить в центр вывода на экране
; На выходе координаты левого верхнего угла обзорного окна на карте
; Вход: DE - pos,  D - x, E - y
; Выход: DE - pos,  D - x, E - y

VIEW_CENTER:
.centr_X:
  LD A,D; проверяем X на минимальность
  SUB VIEW_SCR_WIDTH_HALF; вычитаем из A половину ширины экрана
  JR NC, .centr_X_max
  LD D, #00; обнуляем X
  JR .centr_Y
.centr_X_max:
  CP VIEW_SCR_WINDOW_MAX_X
  JR C, .set_x
  LD D, VIEW_SCR_WINDOW_MAX_X-1
  JR .centr_Y
.set_x:
  LD D, A
.centr_Y:
  LD A, E; проверяем X на минимальность
  SUB VIEW_SCR_WIDTH_HALF
  JR NC, .centr_Y_max
  LD E, #00; обнуляем X
  JP .center_map_end
.centr_Y_max:
  CP VIEW_SCR_WINDOW_MAX_Y
  JR C, .set_y
  LD E, VIEW_SCR_WINDOW_MAX_Y-1
  JP .center_map_end
.set_y:
  LD E, A
.center_map_end:
  RET
