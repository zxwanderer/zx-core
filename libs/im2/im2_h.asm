; _intTab must be aligned 256 (#BC00)
; _vector must be high _vector = low _vector  (#BEBE)

	include "../stack/push_pop_h.asm"

; заполнить таблицу _initTab указателями на _vector_vector
	MACRO IM2_INIT _intTab, _vector
	  ld hl,_intTab
	  ld de,_intTab+1
	  ld bc,0x100
	  ld a,h
	  ld i,a
	  ld (hl),high _vector
	  ldir
	  im 2
  	ENDM

    MACRO IM2_ORG_VECTOR_TABLE _intTab
ORG _intTab
    align 256
	ASSERT $ == _intTab
    ds 257,0
    ENDM

	MACRO IM2_ROUTINES_ORG_START _vector
	ASSERT $ < _vector
ORG _vector
		DI
		LD (_im2_sp_addr), SP
		DO_PUSH_ALL_REGISTRY
		ENDM

	MACRO IM2_ROUTINES_END
  	DO_POP_ALL_REGISTRY
_im2_sp_addr: equ $+1
		LD SP, #0000
  	EI
  	RET
		ENDM


; Example here :
; 
; INT_VECTOR equ #BEBE
; INT_TABLE equ $BD00
; 
; ...
; di
; IM2_INIT INT_TABLE, INIT_VEC
; ei
; 
; ...
; 
; // ------------- interrupt tabs
; IM2_ORG_VECTOR_TABLE INT_TABLE
; 
; // ------------- im2 routines
; IM2_ROUTINES_ORG_START INIT_VEC
; ld sp, Im2_internal_stack
; 
; ...
; 
; IM2_ROUTINES_END
; 
; ds 100,0
; Im2_internal_stack equ $-1
