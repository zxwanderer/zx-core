; DEFINE Upkr.buffer #F000 // unpack buffer must be aligned to 256
; LD IX, source
; LD DE, destination
; exx
; CALL Upkr.unpack

  MODULE Upkr
define UPKR_PROBS_ORIGIN Upkr.buffer
    include "external_sources/packers/upkr/z80_unpacker/unpack.asm"
unpack equ upkr.unpack
  ENDMODULE
