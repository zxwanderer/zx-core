  ifndef _TABLE_SCAN_BY_INDEX_PTR_ASM_
  define _TABLE_SCAN_BY_INDEX_PTR_ASM_

  include "../registers/hl_ptr_to_hl_h.asm"
  include "../result/set_result.asm"

; Найти запись по индексу в таблице вида [#index][#pointer]
; Если индекс найден то в HL возвращается указатель #pointer

; На входе:
;   A - индекс
;   HL - указатель на таблицу
; На выходе:
;   HL - найденное значения
;   retFalse - если не нашли Carry = 0
TABLE_SCAN_BY_INDEX_PTR:
  LD (.index_set+1), A

.loop
  LD A, (HL)
  AND A  ;проверяем на 0
	JP Z, ret_false

.index_set:
  CP #00
  JR Z, .found
  INC HL
  INC HL
  INC HL
  JR .loop

.found:
  INC HL ; передвигаем с действия на указатель
  HL_PTR_TO_HL
  retTrue

  endif
