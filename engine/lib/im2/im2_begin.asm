	di
	push af,bc,de,hl
	exx
	ex af, af'
	push af,bc,de,hl,ix,iy

	; ld a,(MEMORY_CUR_BANK)
	; push af

	; LD HL, (frame_counter)
  	; INC HL
  	; LD (frame_counter), HL
