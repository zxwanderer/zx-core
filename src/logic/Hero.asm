MODULE Hero

; --------------------------------------------------------------------------------------
; Инициализация персонажей на карте, переход на первого персонажа
; --------------------------------------------------------------------------------------
initHeroes:
.init_loop: 
  LD B, HeroesNum
  LD HL, HEROES_SET
  LD DE, Hero
  PUSH BC
  PUSH DE
  PUSH HL

  PUSH HL
  POP IX

  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  CALL Cells.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  CALL update_sprite

  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ .init_loop

; --------------------------------------------------------------------------------------
; Переход на первого персонажа
; --------------------------------------------------------------------------------------
firstChar:
  LD HL, HEROES_SET
  ld (LOGIC_activeHero_ptr), HL
  XOR A
  LD (LOGIC_curHeroNum), A
  RET

; --------------------------------------------------------------------------------------
; Циклический переход на следующего персонажа,
; если дошли до последнего то переходим на первого
; --------------------------------------------------------------------------------------
loopNextChar:
  CALL nextChar
  RET NZ
  JP firstChar

lookAtChar:
  LD IX, (LOGIC_activeHero_ptr)
  LD D,  (IX+Hero.pos.x)
  LD E,  (IX+Hero.pos.y)
  CALL View.lookAt
  MemSetBank graphBank
  JP View.draw

; --------------------------------------------------------------------------------------
; Переход на следующего персонажа
; Выход:
;    если установлен флаг Z, значит мы на последнем персонаже и дальше перейти нельзя
; --------------------------------------------------------------------------------------
nextChar:
  LD A, (LOGIC_curHeroNum)
  INC A
  CP HeroesNum
  RET Z; если у нас обнулился счетчик - возвращаемся
  LD (LOGIC_curHeroNum), A
  LD DE, (LOGIC_activeHero_ptr)
  LD HL, Hero
  ADD HL, DE
  LD (LOGIC_activeHero_ptr), HL
  OR 2
  RET


lookAround: 
  LD IX, (LOGIC_activeHero_ptr)
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  CALL EventsMap.lookAround
  RET

; --------------------------------------------------------------------------------------
; Движение или поворот текущего персонажа
; Вход:
;   B - направление
; --------------------------------------------------------------------------------------
move:
  LD IX, (LOGIC_activeHero_ptr)
  LD A, (IX+Hero.dir)
  CP B
  JR Z, stand

.char_rot
  LD (IX+Hero.dir), B
; --------------------------------------------------------------------------------------
; меняем спрайт героя в зависимости от направления персонажа
; Вход:
;  IX - указатель на героя
; --------------------------------------------------------------------------------------
update_sprite:
  LD B,(IX+Hero.base_spr)
  LD A,(IX+Hero.dir)
  ADD A, B
  DEC A; delta spr = dir - 1
  LD (IX+Hero.sprite), A
.set_ground:
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.sprite)
  CALL Cells.set
  RET

stand:
  LD A, do_stand
; --------------------------------------------------------------------------------------
; Действие персонажа по направлению взгляда
; Вход:
;   IX - указатель на героя
;   A - действие
; --------------------------------------------------------------------------------------
do:
  LD (.action), A
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.dir)
  CALL MOVE_CALC_XY ; в DE позиция действия
  RET NC
  LD (LOGIC_MapCell_xy), DE
  CALL Cells.calc_pos
  LD (LOGIC_MapCell_ptr), HL
.action equ $+1
  LD A, #00

.do_stand
  LD D, (IX+Hero.pos.x)
  LD E, (IX+Hero.pos.y)
  LD A, (IX+Hero.ground)
  CALL Cells.set ; вернули на место землю

  LD DE, (LOGIC_MapCell_xy)
  LD (IX+Hero.pos.x), D
  LD (IX+Hero.pos.y), E ; установили новые координаты 

  LD HL, (LOGIC_MapCell_ptr)
  LD A, (HL)
  LD (IX+Hero.ground), A ; сохранили землю
  JP update_sprite

  ENDMODULE
