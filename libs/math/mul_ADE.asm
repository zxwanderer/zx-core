  ifndef _MUL_ADE_ASM_
  define _MUL_ADE_ASM_

; А - индекс
; DE - размер данных
; на выходе HL = A*DE
mul_ADE:
	LD HL, #0000
	OR A
	RET Z
	LD B,A
.mul_ADE_loop:
	ADD HL, DE
	DJNZ .mul_ADE_loop
	RET

	endif
