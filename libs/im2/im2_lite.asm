 	ifndef _IM2_LITE_H_
  define _IM2_LITE_H_

; via https://zxpress.ru/article.php?id=3480

  MACRO IM2_INIT vector_high?
    LD   A,vector_high?
    LD   I,A
    IM   2
  ENDM

; заполняем таблицу указателями на вектор прерывания vector_vector
; need before use ORG INT_TABLE aligned by 255 (#BC00)
; ORG int_table
  MACRO IM2_TABLE vector?
    ds 257, vector?
  ENDM

; need before use ORG int_vector_addr, high int_vector_addr = low int_vector_addr (#BEBE)
; ORG int_vector_addr
  MACRO IM2_JP_ROUTINES routines_addr?
    JP routines_addr?
  ENDM

  endif
