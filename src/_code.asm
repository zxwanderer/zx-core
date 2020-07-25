include "engine/lib/im2/im2_h.asm"
start:
    DI

    LD A, %00000100
    call SCREEN_SET_COLORS

    MemSetBank textBank
    LD DE, SCREEN_ADDR
    LD HL, TEXT_HELLO
    call Text68.print_at

    MemSetBank muzBank
    ld hl, music1
    
    CALL Player.INIT

    SetIM2 interruptTab, INIT_VEC

    EI
loop:
    LD A, 1
    OUT (#FE), A
    LD A, 2
    OUT (#FE), A
    LD A, 3
    OUT (#FE), A
    LD A, 4
    OUT (#FE), A
    LD A, 5
    OUT (#FE), A
    LD A, 6
    OUT (#FE), A
    LD A, 7
    OUT (#FE), A
    JP loop

include "engine/lib/screen/set_colors.asm"
include "engine/lib/screen/calc_down_pos.asm"
include "engine/lib/screen/clear.asm"
include "engine/lib/screen/addr_to_attr.asm"
; include "engine/lib/screen/flip.asm"

include "engine/lib/sprites/sprites_16_h.asm"
include "engine/lib/sprites/show_tile_16.asm"
include "engine/lib/sprites/index_to_ptr_16.asm"
include "engine/lib/sprites/show_map_16.asm"
include "engine/lib/memory/set_bank.asm"
