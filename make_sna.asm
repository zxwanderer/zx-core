include "./src/main.asm"

	display 'PAGE0 end: ', $

	display /d, 'Total bytes used: ', $ - start

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna 'program.sna', start			; SNA_FILENAME defined in Makefile
	endif
