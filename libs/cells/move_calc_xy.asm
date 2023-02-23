 MACRO m_check_left
    LD A,D
    DEC A
    JP M, check_act_no
    LD D,A
  ENDM

  MACRO m_check_right
    LD A,D
    INC A
    CP TILE_MAP_SIZE_WIDTH
    JR NC, check_act_no
    LD D,A
  ENDM

  MACRO m_check_up
    LD A,E
    DEC A
    JP M, check_act_no
    LD E,A
  ENDM

  MACRO m_check_down
    LD A,E
    INC A
    CP TILE_MAP_SIZE_HEIGHT
    JP NC, check_act_no
    LD E,A
  ENDM

; -------------------------------------------------
; Input:
;  D - x, E - y
;  A - dir
; Output: 
;  DE - new pos
; -------------------------------------------------
MOVE_CALC_XY:
  CP dir_up
  JR Z, check_up
  CP dir_down
  JR Z, check_down
  CP dir_left
  JR Z, check_left
  CP dir_right
  JR Z, check_right

  CP dir_down_left
  JR Z, check_down_left
  CP dir_down_right
  JR Z, check_down_right
  CP dir_up_left
  JR Z, check_up_left
  CP dir_up_right
  JR Z, check_up_right

  CP dir_center
  JR Z, check_center

check_act_no:
  retFalse
  
check_down_left:
  m_check_down
  m_check_left
  JR check_act_yes

check_down_right:
  m_check_down
  m_check_right
  JR check_act_yes

check_up_left:
  m_check_up
  m_check_left
  JR check_act_yes

check_up_right:
  m_check_up
  m_check_right
  JR check_act_yes

check_up:
  m_check_up
  JR check_act_yes

check_down:
  m_check_down
  JR check_act_yes

check_left:
  m_check_left
  JR check_act_yes

check_right:
  m_check_right

check_center:
check_act_yes:
    retTrue
