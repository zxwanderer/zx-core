    DEVICE 	ZXSPECTRUM128
	ORG	#6000
INIT_VEC equ #7D7D

include "engine/lib/keyboard/scancode_h.asm"
include "engine/lib/im2/im2_h.asm"

start:
    DI
    call SCREEN_CLEAR
    SetIM2 interruptTab, INIT_VEC
    EI
loop:
    OUT (#FE), A
    INC A
    JP loop

include "engine/lib/screen/clear.asm"
include "engine/lib/memory/set_bank.asm"

im2_routines:
    ld a,r
    out (#fe),a
    ret

CmdTable:
    DUP 256
    DW #0000
    EDUP
CmdTableEnd:

	align 256
interruptTab:	ds 257

    assert $<#7D7D
    org INIT_VEC
include "engine/lib/im2/im2.asm"
