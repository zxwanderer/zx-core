	device zxspectrum128

	org #6000
start:	di : 

	ld hl, music_data
  	call MUSIC_INIT
	ld a,#5c, i,a, hl,interr, (#5cff),hl : im 2 : ei

loop:
	halt
	inc a
	out (#fe), a
	halt
	jr loop

	include "music.asm"
	
interr:
	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy

	call MUSIC_PLAY

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
  