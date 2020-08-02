_endByte equ 0

MACRO mLDE ;LD DE, (HL)
  LD E, (HL)
  INC HL
  LD D, (HL)
  INC HL
ENDM

MACRO retTrue
  SCF ; устанавливаем бит переноса ( Carry = 1 )
  RET
ENDM

MACRO retFalse
  SCF ; устанавливаем бит переноса и инвертируем его ))
  CCF
  RET
ENDM
