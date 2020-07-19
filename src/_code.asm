include "engine/lib/im2/im2_h.asm"
start:
    DI
    call SCREEN_CLEAR
    SetIM2 interruptTab, INIT_VEC
    EI
    LD a, 1
loop:
    OUT (#FE), A
    LD A, R
    JP loop

include "engine/lib/screen/clear.asm"
include "engine/lib/memory/set_bank.asm"
