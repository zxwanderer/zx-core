  MACRO PushAllRegistry
    ; di
	  push af,bc,de,hl
	  exx
	  ex af, af'
	  push af,bc,de,hl,ix,iy
  ENDM

  MACRO PopAllRegistry
	  pop iy,ix,hl,de,bc,af
	  ex af, af'
	  exx
	  pop hl,de,bc,af
	  ; ei
  ENDM
