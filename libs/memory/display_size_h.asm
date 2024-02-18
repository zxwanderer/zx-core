   ifndef _DISPLAY_SIZE_H_
   define _DISPLAY_SIZE_H_

  MACRO DISPLAY_SIZE name, item
  display name, ' ', item,      '-', item_END    -1, ', size: ' , /D, item_END - item
  ENDM

   endif
