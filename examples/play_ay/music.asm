MUSIC_INIT: equ Player.INIT
MUSIC_PLAY: equ Player.PLAY

MODULE Player
  include "ay/PTSPLAY.asm"
ENDMODULE

music_data:
  ; incbin "EA - Epilogue (ea2org) (2020).pt3"
  incbin "keyjee.pt3"
