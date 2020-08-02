include "engine/lib/im2/im2_h.asm"
include "engine/lib/keyboard/scancode_h.asm"
include "engine/lib/keyboard/input_h.asm"
include "src/middleware/view_h.asm"

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

    MemSetBank mapBank
    LD DE, #1212
    CALL View.lookAt

    MemSetBank graphBank
    CALL View.draw

    EI
loop:
    LD A, (Input.pressButtons)
    AND %00000111
    OUT (#FE), A
    LD HL, keytable
    CALL Input.scanKeys
    LD HL, procButtons
    ; CALL Input.processButtons
    JP loop

keytable:
  DefineKey KEY_Q, BUTTON_UP
  DefineKey KEY_A, BUTTON_DOWN
  DefineKey KEY_O, BUTTON_LEFT
  DefineKey KEY_P, BUTTON_RIGHT
  DefineKey KEY_M, BUTTON_FIRE
  DefineKey KEY_SPACE, BUTTON_FIRE
  DefineKey KEY_ENTER, BUTTON_FIRE
  defb 0

procButtons:

include "engine/lib/screen/set_colors.asm"
include "engine/lib/screen/calc_down_pos.asm"
include "engine/lib/screen/clear.asm"
include "engine/lib/screen/addr_to_attr.asm"

include "engine/lib/tiles16/show.asm"
include "engine/lib/tiles16/index_to_ptr.asm"

include "engine/lib/keyboard/input.asm"

include "src/middleware/view.asm"

include "engine/lib/memory/set_bank.asm"
