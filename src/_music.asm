MUSIC_INIT: equ Player.INIT
MUSIC_PLAY: equ Player.PLAY

    MODULE Player
    include "engine/lib/ay/PTSPLAY.asm"
    ENDMODULE

music1:
    incbin "data/music/EA - Epilogue (ea2org) (2020).pt3"
music2:
    incbin "data/music/keyjee.pt3"
