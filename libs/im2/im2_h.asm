; _intTab must be aligned 256 (#BC00)
; _vector must be high _vector = low _vector  (#BEBE)

	MACRO SetIM2 _intTab, _vector
	  ld hl,_intTab
	  ld de,_intTab+1
	  ld bc,0x100
	  ld a,h
	  ld i,a
	  ld (hl),high _vector
	  ldir
	  im 2
  	ENDM
