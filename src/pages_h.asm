    ; mempages
; gfxBank equ #10 //0 - графика
                  //0
scrBank equ #11   //1 - скрипты
                  //2 - дублирование #8000
textBank equ #13  //3 - страница текстовых сообщений
mapBank  equ #14  //4 - карта
                  //5 - дублирование #4000
                  //6
muzBank  equ #17  //7 - screen ?

    MACRO MemSetScriptBank
        ld a, scrBank
        call MEMORY_SET_BANK
    ENDM

    MACRO MemSetTextBank
        ld a, textBank
        call MEMORY_SET_BANK
    ENDM

    ; MACRO MemSetGraphBank
    ;     ld a, gfxBank
    ;     call Memory.setBank
    ; ENDM

    MACRO MemSetMuzBank
        ld a, muzBank
        call MEMORY_SET_BANK
    ENDM

    MACRO MemSetMapBank
        ld a, mapBank
        call MEMORY_SET_BANK
    ENDM

    MACRO MemSetBank bank_
        ld a, bank_
        call MEMORY_SET_BANK
    ENDM
