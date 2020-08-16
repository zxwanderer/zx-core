MODULE Hero

; 
; Инициализация персонажей на карте, переход на первого персонажа
; 
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
  call View.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ .init_loop

;
; Переход на первого персонажа
;
firstChar:
  LD HL, HEROES_SET
  ld (LOGIC_activeHero_ptr), HL
  XOR A
  LD (LOGIC_curHeroNum), A
  RET

;
; Циклический переход на следующего персонажа,
; если дошли до последнего то переходим на первого
;
loopNextChar:
  CALL nextChar
  RET NZ
  JP firstChar

; 
; Переход на следующего персонажа
; Выход:
;    если установлен флаг Z, значит мы на последнем персонаже и дальше перейти нельзя
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
  
  ENDMODULE
