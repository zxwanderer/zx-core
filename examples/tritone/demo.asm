	device zxspectrum48

	org #6000
start:
  LD HL, music_data

just_play:
  CALL Tritone.play
	CALL noKey
	JP just_play

noKey:
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr nz,noKey
	ret

	include "beeper/tritone/play.asm"
	
music_data:
		include "AER_music.asm"

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	; build
	; if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
		savebin BIN_FILENAME, start, $-start 	; BIN_FILENAME defined in Makefile
	; endif
  