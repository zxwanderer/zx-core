  MACRO HL_PTR_TO_HL
  LD (.ptr+1), HL
.ptr
  LD HL, (#0000)
  ENDM
