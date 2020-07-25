; mempages
graphBank  equ #10    //0 - графика
scriptBank equ #11   //1 - скрипты
                     //2 - #8000
textBank   equ #13   //3 - страница текстовых сообщений
mapBank    equ #14   //4 - карта
                     //5 - #4000
muzBank     equ #16  //6
                     //7 - screen ?

    MACRO MemSetBank bank_
        ld a, bank_
        call MEMORY_SET_BANK
    ENDM
