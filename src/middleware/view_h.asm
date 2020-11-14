scrHeight equ 11
scrWidth equ 16
mapSize equ 32

TILE_INDEX_TO_PTR equ TILE16_INDEX_TO_PTR
SHOW_TILE_ON_SCREEN equ TILE_16_SHOW

scrWindowMaxX equ mapSize-scrWidth+1  ; максимальная позиция окна отображения карты, иначе выходим за границу
scrWindowMaxY equ mapSize-scrHeight+1 ; максимальная позиция окна отображения карты, иначе выходим за границу
scrWidthHalf equ scrWidth/2;  8
scrHeightHalf equ scrHeight/2; 6
