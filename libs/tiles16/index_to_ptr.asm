  ifndef _INDEX_TO_PTR_ASM_
  define _INDEX_TO_PTR_ASM_

; TILE_SET - указатель на начало спрайтов
; переводим индекс карты в указатель на начало данных спрайта
; A - номер спрайта
; на выходе HL - указатель на данные спрайта
; затрагивается регистр BC!!!
TILE16_INDEX_TO_PTR:
  LD L, A
  LD H, 0; загружаем номер спрайта в HL
  ADD HL,HL; x2
  ADD HL,HL; x4
  PUSH HL; // запоминаем x4
  ADD HL,HL; x8
  ADD HL,HL; x16
  ADD HL,HL; x32
  POP BC; // снимаем со стека x4 - еще 4 байта цветности
  ADD HL, BC
  LD BC, TILE_SET; указатель на начало спрайтов
  ADD HL, BC
  RET

  endif
