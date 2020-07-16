    DEVICE 	ZXSPECTRUM128
	ORG	#8000

start:
    EI
loop:
    OUT (#FE), A
    INC A
    JP loop
