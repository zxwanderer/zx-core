 	ifndef _HL_PTR_TO_HL_H_
  define _HL_PTR_TO_HL_H_

  MACRO HL_PTR_TO_HL
  LD (.ptr+1), HL
.ptr
  LD HL, (#0000)
  ENDM

  endif
