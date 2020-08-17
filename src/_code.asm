include "engine/lib/defines_h.asm"
include "engine/lib/im2/im2_h.asm"
include "engine/lib/keyboard/scancode_h.asm"
include "engine/lib/keyboard/input_h.asm"
include "src/middleware/view_h.asm"
include "src/middleware/directions_h.asm"

include "engine/lib/logic/Point_h.asm"
include "src/logic/Hero_h.asm"

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
    ; call Player.INIT
    
    MemSetBank mapBank
    call Hero.initHeroes
    
    SetIM2 interruptTab, INIT_VEC

    EI

loop:

IsNeedUpdate: equ $+1
  LD A, #01
  OR A
  JP Z, NoScreenUpdate
  XOR A
  LD (IsNeedUpdate), A

  HALT
  MemSetBank mapBank

PosXY: equ $+1

  LD DE, #0000
  CALL View.lookAt

  MemSetBank graphBank
  CALL View.draw

NoScreenUpdate:
  LD HL, keyMappingTable
  CALL Input.scanKeys
  LD HL, procButtonsUDLRF
  LD A, (Input.pressButtons)
  CALL KEYBOARD_PROCESS_BUTTONS
  XOR A
  OUT (#FE), A
  JP loop

keyMappingTable:
  DefineKey KEY_Q, BUTTON_UP
  DefineKey KEY_A, BUTTON_DOWN
  DefineKey KEY_O, BUTTON_LEFT
  DefineKey KEY_P, BUTTON_RIGHT
  DefineKey KEY_M, BUTTON_FIRE
  DefineKey KEY_SPACE, BUTTON_FIRE
  DefineKey KEY_ENTER, BUTTON_FIRE
  defb _endByte

procButtonsUDLRF:
  defw proc_BUTTON_UP
  defw proc_BUTTON_DOWN
  defw proc_BUTTON_LEFT
  defw proc_BUTTON_RIGHT
  defw proc_BUTTON_FIRE
  defb _endByte


proc_BUTTON_UP:
  LD A, dir_up
  LD (IsNeedUpdate), A
  LD DE, (PosXY)
  CALL MOVE_CALC_POS
  LD (PosXY), DE
  RET

proc_BUTTON_DOWN:
  LD A, dir_down
  LD (IsNeedUpdate), A
  LD DE, (PosXY)
  CALL MOVE_CALC_POS
  LD (PosXY), DE
  RET

proc_BUTTON_LEFT:
  LD A, dir_left
  LD (IsNeedUpdate), A
  LD DE, (PosXY)
  CALL MOVE_CALC_POS
  LD (PosXY), DE
  RET

proc_BUTTON_RIGHT:
  LD A, dir_right
  LD (IsNeedUpdate), A
  LD DE, (PosXY)
  CALL MOVE_CALC_POS
  LD (PosXY), DE
  RET

proc_BUTTON_FIRE:
  RET

include "src/logic/logic_vars.asm"
include "src/logic/heroes_data.asm"

include "src/logic/Hero.asm"

include "engine/lib/screen/set_colors.asm"
include "engine/lib/screen/calc_down_pos.asm"
include "engine/lib/screen/clear.asm"
include "engine/lib/screen/addr_to_attr.asm"

include "engine/lib/tiles16/show.asm"
include "engine/lib/tiles16/index_to_ptr.asm"

include "engine/lib/keyboard/input.asm"
include "engine/lib/keyboard/process_buttons.asm"

include "src/middleware/view.asm"
include "src/middleware/move_calc_pos.asm"

include "engine/lib/memory/set_bank.asm"
