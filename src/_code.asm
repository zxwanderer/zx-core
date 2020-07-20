include "engine/lib/im2/im2_h.asm"
start:
    DI

    call SCREEN_CLEAR

    MemSetBank muzBank
    ld hl, music2
    CALL Player.INIT

    SetIM2 interruptTab, INIT_VEC

    EI
loop:
    LD A, R
    AND %00000111
    OUT (#FE), A
    JP loop

include "engine/lib/screen/clear.asm"
include "engine/lib/memory/set_bank.asm"
