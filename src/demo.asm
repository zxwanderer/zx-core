	device zxspectrum128

	define _DEBUG_BORDER

	org #6000
start:	di : ld sp, $-2

	xor a : out (#fe), a
	
	ld hl,#4000, de,#4001, bc,#1800, (hl),l : ldir
	ld bc,#02ff, (hl),#47 : ldir

	ld a,#5c, i,a, hl,interr, (#5cff),hl : im 2 : ei

	; main loop
1	xor a : out (#fe), a
	inc a : inc a :  out (#fe), a
	jr 1b

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_BORDER : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _DEBUG_BORDER : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  