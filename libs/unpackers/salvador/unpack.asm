	; LD HL, source
	; LD DE, destination
	; CALL DecompressZX0v1

  MODULE Salvador
    include "external_sources/packers/salvador/asm/Z80/unzx0v1_fast.asm"
unpack equ DecompressZX0v1
  ENDMODULE
