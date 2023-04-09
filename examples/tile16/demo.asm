	device zxspectrum48

TILE_SET equ #0000
MAP_DATA equ $0000
MAP_MASK equ $0000

SCREEN_ADDR equ #4000
SCREEN_ATTR_ADDR equ SCREEN_ADDR + #1800

TILE_MAP_SIZE_WIDTH equ 10

TILE_SCR_WIDTH equ 16
TILE_SCR_HEIGTH equ 12

	org #6000
start:

loop:
	LD HL, MAP_DATA
	CALL COPY_TO_BUFFER
	CALL TILE16_SHOW_SCREEN
  jp loop

	include "screen/addr_to_attr.asm"
	
	include "tiles16/show.asm"
	include "tiles16/index_to_ptr.asm"
	include "tiles16/show_screen.asm"
	include "tiles16/copy_to_buffer.asm"

VIEW_BUFFER:
	include "tiles16/view_buffer.asm"

	display 'PAGE0 end: ', $
	display /d, 'Total bytes used: ', $ - start

	if (_ERRORS == 0 && _WARNINGS == 0)
		savesna SNA_FILENAME, start			; SNA_FILENAME defined in Makefile
	endif
  