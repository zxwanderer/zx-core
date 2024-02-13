 	ifndef _SET_RESULT_H_
  define _SET_RESULT_H_

  MACRO retTrue
    SCF ; устанавливаем бит переноса ( Carry = 1 )
    RET
  ENDM

  MACRO retFalse
    SCF ; устанавливаем бит переноса и инвертируем его ))
    CCF
    RET
  ENDM

  endif
