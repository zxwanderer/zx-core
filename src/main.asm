    DEVICE 	ZXSPECTRUM128
	ORG	#8000

start:
    EI
loop:
    LD A,R
    OUT (#FE), A
    JP loop
