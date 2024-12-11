MUSIC_INIT: 
  ld hl, music_data
  call  Player.init
  ret
MUSIC_PLAY: equ Player.play
MUSIC_STOP: equ Player.stop

MODULE Player
  include "ay/psg/l4_psg_player.asm"
ENDMODULE

music_data:
  incbin "./output/music.psg.pack"
