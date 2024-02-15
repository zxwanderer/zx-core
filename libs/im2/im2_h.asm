; _intTab must be aligned 256 (#BC00)
; _vector must be high _vector = low _vector  (#BEBE)

	include "../stack/push_pop_h.asm"

	MACRO SET_IM2 _intTab, _vector
	  ld hl,_intTab
	  ld de,_intTab+1
	  ld bc,0x100
	  ld a,h
	  ld i,a
	  ld (hl),high _vector
	  ldir
	  im 2
  	ENDM

	MACRO IM2_ROUTINES_ORG_START _vector
ORG _vector
		DI
		DO_PUSH_ALL_REGISTRY
		ENDM

	MACRO IM2_ROUTINES_END
  	DO_POP_ALL_REGISTRY
  	EI
  	RET
		ENDM
