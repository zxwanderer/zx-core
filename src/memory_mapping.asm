
DEVICE 	ZXSPECTRUM128

INIT_VEC equ #7D7D

// ------------- code
    ORG	#6000
prog_start:
    include "_code.asm"
prog_end:

// ------------- interrupt tabs
    align 256
interruptTab_start:
interruptTab:	
    ds 257,0
interruptTab_end:

// ------------- im2
    assert $ < INIT_VEC
	ORG INIT_VEC
im2_start:
    include "_im2.asm"
im2_end:
    assert $ < #8000

// ------  music.bin
    SLOT 3
    PAGE 6
    ORG #C000
music_start:
    include "_music.asm"
music_end:

// ------  graph.bin
    SLOT 3
    PAGE 0
    ORG #C000
graph_start:
    include "_graph.asm"
graph_end:

// ------  map.bin
    SLOT 3
    PAGE 4
    ORG #C000
map_start:
    include "_map.asm"
map_end:

// ------  text.bin
    SLOT 3
    PAGE 3
    ORG #C000
text_start:
    include "_text.asm"
text_end:

// ------  scripts.bin
    ; SLOT 3
    ; PAGE 1
    ; ORG #C000
; script_start:
    ; include "./pages/_scripts.asm"
; script_end:

DISPLAY '-----------------------------------'
DISPLAY 'Code:         ', prog_start, '-', prog_end-1, ', size: ', /D, prog_end-prog_start-1
DISPLAY '[Free]:       ', prog_end, '-', interruptTab_start-1, ', size: ', /D, interruptTab_start-prog_end-1
DISPLAY 'interruptTab: ', interruptTab_start, '-', interruptTab_end-1, ', size: ', /D, interruptTab_end-interruptTab_start-1
DISPLAY '[Free]:       ', interruptTab_end, '-', im2_start-1, ', size: ', /D, im2_start-interruptTab_end-1
DISPLAY 'Im2:          ', im2_start, '-', im2_end-1, ', size: ', /D, im2_end-im2_start-1
DISPLAY '[Free]:       ', im2_end, '-0x7FFF, size: ', /D, #8000 - im2_end
DISPLAY '-----------------------------------'

  DISPLAY 'Music:  ', /D, music_end-music_start, ' free: ', /D, 0x10000 - music_end
;   DISPLAY 'Script: ', /D, script_end-script_start, ' free: ', /D, 0x10000 - script_end
  DISPLAY 'Text:   ', /D, text_end-text_start, ' free: ', /D, 0x10000 - text_end
  DISPLAY 'Map:    ', /D, map_end-map_start, ' free: ', /D, 0x10000 - map_end
  DISPLAY 'Graph:  ', /D, graph_end-graph_start, ' free: ', /D, 0x10000 - graph_end
  DISPLAY '-----------------------------------'
