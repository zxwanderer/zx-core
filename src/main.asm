    DEVICE 	ZXSPECTRUM128
	ORG	#8000

    MACRO INSERT_COMMAND cmd_, addr_
__tmp_org__ = $
    ORG CmdTable + 2 * @__command_number__
cmd_ EQU $ - CmdTable    
    DW addr_
    ASSERT $ <= CmdTableEnd
    ORG __tmp_org__
@__command_number__ = __command_number__ + 1
    ENDM

start:
    EI
loop:
    OUT (#FE), A
    INC A
    JP loop

CmdTable:
    DUP 256
    DW #0000
    EDUP
CmdTableEnd:
