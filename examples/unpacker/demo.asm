	device zxspectrum48
	org #6000
start:
	; di
	; LD HL, picture
	; LD DE, #4000
	; LD BC, #2000
	; ldir 
	; halt

	LD HL, picture_pack:
	LD DE, #4000
	CALL DecompressZX0v1
loop:
	jp loop

unpacker:
	include "unpackers/salvador/unzx0v1_fast.asm"

picture_pack:
	incbin "./output/prof4d_np_2015_CC_Winter.sal"
; picture:
	; incbin "prof4d_np_2015_CC_Winter.scr"
	
	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
