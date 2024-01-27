MUSIC_INIT: equ Player.INIT
MUSIC_PLAY: equ Player.PLAY

MODULE Player
  include "ay/PTSPLAY.asm"
ENDMODULE

music_data:
  incbin "keyjee.pt3"
