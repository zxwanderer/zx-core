include "engine/lib/im2/im2_h.asm"
include "engine/lib/keyboard/scancode_h.asm"
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
    JP loop

keytable:
  KEY_Q
  defb BUTTON_UP
  KEY_A
  defb BUTTON_DOWN
  KEY_O
  defb BUTTON_LEFT
  KEY_P
  defb BUTTON_RIGHT
  KEY_M
  defb BUTTON_FIRE
  KEY_SPACE
  defb BUTTON_FIRE
  KEY_ENTER
  defb BUTTON_FIRE
  defb 0

include "engine/lib/screen/set_colors.asm"
include "engine/lib/screen/calc_down_pos.asm"
include "engine/lib/screen/clear.asm"
include "engine/lib/screen/addr_to_attr.asm"

include "engine/lib/tiles16/show.asm"
include "engine/lib/tiles16/index_to_ptr.asm"

include "engine/lib/keyboard/input.asm"

include "src/middleware/view.asm"

include "engine/lib/memory/set_bank.asm"
