ngBegin:
	di
	ld (sp_saved_im+1), sp
	ld sp, stack_im
	push af,bc,de,hl
	exx
	ex af, af'
	push af,bc,de,hl,ix,iy

	ld a,(MEMORY_CUR_BANK)
	push af

	LD HL, (frame_counter)
  	INC HL
  	LD (frame_counter), HL

	CALL im2_routines

	pop	af
	call MEMORY_SET_BANK

	pop iy,ix,hl,de,bc,af
	ex af, af'
	exx
	pop hl,de,bc,af
sp_saved_im:
	LD SP, #0000
	ei
	ret

frame_counter: dw 0

stack_im_begin:
  DEFS 50, 0
stack_im: equ $

    DISPLAY "Im2 begin: ", ngBegin, " end: ", $
    DISPLAY '-----------------------------------'
