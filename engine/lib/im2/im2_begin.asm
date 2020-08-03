	di
	push af,bc,de,hl
	exx
	ex af, af'
	push af,bc,de,hl,ix,iy

	LD A, (MEMORY_CUR_BANK)
	LD (restore_mem_bank+1), A
