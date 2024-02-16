   ifndef _DEFINE_KEY_H_
   define _DEFINE_KEY_H_

   include "./scancode_h.asm"

   MACRO DefineKey _key, _proc
    _key
    dw _proc
   ENDM

   endif
