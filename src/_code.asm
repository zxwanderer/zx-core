include "engine/lib/im2/im2_h.asm"
start:
    DI

    ; LD A,%00000111
    ; call SCREEN_SET_COLORS

    MemSetBank textBank
    LD DE, SCREEN_ADDR
    LD HL, TEXT_HELLO
    call Text68.print_at

    MemSetBank muzBank
    ld hl, music2
    CALL Player.INIT

    SetIM2 interruptTab, INIT_VEC

    EI
loop:
    HALT
    LD A, 1
    OUT (#FE), A
    ; call SCREEN_FLIP
    LD A, 2
    OUT (#FE), A
    JR loop

include "engine/lib/screen/set_colors.asm"
include "engine/lib/screen/calc_down_pos.asm"
include "engine/lib/screen/clear.asm"
include "engine/lib/screen/flip.asm"

include "engine/lib/memory/set_bank.asm"
