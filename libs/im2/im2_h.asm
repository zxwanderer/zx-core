 	ifndef _IM2_H_
  define _IM2_H_

	include "../stack/push_pop_h.asm"

; логика вычислений адресов:
; INT_VECTOR_h equ high INT_VECTOR
; INT_VECTOR_h_1 equ INT_VECTOR_h + 1
; INT_VECTOR_END equ INT_VECTOR + 257

; INT_ROUTINE equ INT_VECTOR_h_1 * 256 + INT_VECTOR_h_1
; INT_ROUTINE_END equ INT_ROUTINE + 3

	; инициализация прерываний, честно взято из исходников демки Survivesection
	; таблицу прерываний INT_VECTOR заполняем указателями на INT_ROUTINE
	; по адресу INT_ROUTINE располагается переход на interrupt_routine, которая уже может быть
	; по любому адресу
	; 
	; Для использования должна быть определена переменная 
	MACRO IM2_INIT_JP vector?, interrupt_routine? 
INT_VECTOR_h equ high vector?
INT_VECTOR_h_1 equ INT_VECTOR_h + 1
INT_VECTOR_END equ vector? + 257

INT_ROUTINE equ INT_VECTOR_h_1 * 256 + INT_VECTOR_h_1
INT_ROUTINE_END equ INT_ROUTINE + 3

  LD HL, vector?
  LD B,0
  LD A, (high INT_VECTOR)+1
.init_loop:
  LD (HL),A
  INC HL
  DJNZ .init_loop
  LD (HL),A
  LD H,(high INT_VECTOR)+1
  LD L,H
  LD (HL),#C3
  INC HL
  LD DE,interrupt_routine?
  LD (HL),E
  INC HL
  LD (HL),D
  LD A,high INT_VECTOR
  LD I,A
  IM 2
  EI
  RET
	ENDM

; заполнить таблицу _initTab указателями на _vector_vector
; _intTab must be aligned 256 (#BC00)
; _vector must be high _vector = low _vector  (#BEBE)
	MACRO IM2_INIT _intTab, _vector
	  ld hl,_intTab
	  ld de,_intTab+1
	  ld bc,0x100
	  ld a,h
	  ld i,a
	  ld (hl),high _vector
	  ldir
	  im 2
  	ENDM

    MACRO IM2_ORG_VECTOR_TABLE _intTab
	ORG _intTab
    align 256
	ASSERT $ == _intTab
    ds 257,0
    ENDM

	MACRO IM2_ROUTINES_ORG_START _vector
	ASSERT $ < _vector
	ORG _vector
		DI
		LD (_im2_sp_addr), SP
		DO_PUSH_ALL_REGISTRY
		ENDM

	MACRO IM2_ROUTINES_END
  	DO_POP_ALL_REGISTRY
_im2_sp_addr: equ $+1
		LD SP, #0000
  	EI
  	RET
		ENDM


; Example here :
; 
; INT_VECTOR equ #BEBE
; INT_TABLE equ $BD00
; 
; ...
; di
; IM2_INIT INT_TABLE, INIT_VEC
; ei
; 
; ...
; 
; // ------------- interrupt tabs
; IM2_ORG_VECTOR_TABLE INT_TABLE
; 
; // ------------- im2 routines
; IM2_ROUTINES_ORG_START INIT_VEC
; ld sp, Im2_internal_stack
; 
; ...
; 
; IM2_ROUTINES_END
; 
; ds 100,0
; Im2_internal_stack equ $-1
	endif
