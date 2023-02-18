; копируем тайлы из карты в массив отрисовки
; в HL указатель на индекс первого тайла карты
COPY_TO_BUFFER:
  LD IX, VIEW_BUFFER
  LD B, TILE_SCR_HEIGTH
copy_loop2:
  PUSH BC
  PUSH HL

  LD B,TILE_SCR_WIDTH
copy_loop1:
  PUSH BC

  LD A, (HL)
  AND %10000000
  JR Z, no_copy_cell

  LD A, (HL)
  LD (real_cell_value), A

real_cell_value: equ $+1
  LD A, #00
no_copy_cell:
  LD (IX), A
  INC IX
  INC HL
  POP BC
  DJNZ copy_loop1
  POP HL
  LD BC, TILE_MAP_SIZE_WIDTH
  ADD HL, BC; прибавляем к указателю на начало тайлов ширину - сдвигаем указатель вниз на 1 тайл

  POP BC
  DJNZ copy_loop2
  RET