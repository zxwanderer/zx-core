	device zxspectrum48
	org #6000
start:
loop:

	LD HL, #0000
	LD DE, #4000
	LD BC, #1600
	LDIR

	DI

	LD HL, picture_pack_sal
	LD DE, #4000
	CALL Salvador.unpack

	EI
	
	LD HL, #0000
	LD DE, #4000
	LD BC, #1600
	LDIR

	DI

	DEFINE  Upkr.buffer #F000
	LD IX, picture_pack_upkr
	LD DE, #4000
	EXX
	CALL Upkr.unpack

	EI
	jp loop

unpacker:
	include "unpackers/upkr/unpack.asm"
	include "unpackers/salvador/unpack.asm"

picture_pack_upkr:
	incbin "./output/prof4d_np_2015_CC_Winter.upkr"
picture_pack_sal:
	incbin "./output/helpcomputer0_In_the_shade_2023.sal"
; picture:
	; incbin "prof4d_np_2015_CC_Winter.scr"
	
	display 'Program end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
