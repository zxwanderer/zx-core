include "src/main.asm"

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna 'program.sna', start			; SNA_FILENAME defined in Makefile
	endif
