# For complete documentation of this file, please see Geany's main documentation

[styling]
# foreground;background;bold;italic
default=0x000000;0xffffff;false;false
comment=0x808080;0xffffff;false;false
number=0x007f00;0xffffff;false;false
string=0xff901e;0xffffff;false;false
operator=0x000000;0xffffff;false;false
identifier=0x880000;0xffffff;false;false
cpuinstruction=0x111199;0xffffff;true;false
mathinstruction=0x7f0000;0xffffff;true;false
register=0x000000;0xffffff;true;false
directive=0x3d670f;0xffffff;true;false
directiveoperand=0xff901e;0xffffff;false;false
commentblock=0x808080;0xffffff;false;false
character=0xff901e;0xffffff;false;false
stringeol=0x000000;0xe0c0e0;false;false
extinstruction=0x007f7f;0xffffff;false;false

[keywords]
# all items must be in one line
# this is by default a very simple instruction set; not of Intel or so
instructions=add adc adiw sub subi sbc sbci sbiw and andi or ori eor com neg sbr cbr inc dec tst clr ser mul muls mulsu fmul fmuls fmulsu des rjmp ijmp eijmp jmp rcall icall eicall call ret reti cpse cp cpc cpi sbrc sbrs sbic sbis brbs brbc breq brne brcs brcc brsh brlo brmi brpl brge brlt brhs brhc brts brtc brvs brvc brie brid mov movw ldi lds ld ldd sts st std lpm elpm spm in out push pop xch las lac lat lsl lsr rol ror asr swap bset bclr sbi cbi bst bld sec clc sen cln sez clz sei cli ses cls sev clv set clt seh clh break nop sleep wdr ADD ADC ADIW SUB SUBI SBC SBCI SBIW AND ANDI OR ORI EOR COM NEG SBR CBR INC DEC TST CLR SER MUL MULS MULSU FMUL FMULS FMULSU DES RJMP IJMP EIJMP JMP RCALL ICALL EICALL CALL RET RETI CPSE CP CPC CPI SBRC SBRS SBIC SBIS BRBS BRBC BREQ BRNE BRCS BRCC BRSH BRLO BRMI BRPL BRGE BRLT BRHS BRHC BRTS BRTC BRVS BRVC BRIE BRID MOV MOVW LDI LDS LD LDD STS ST STD LPM ELPM SPM IN OUT PUSH POP XCH LAS LAC LAT LSL LSR ROL ROR ASR SWAP BSET BCLR SBI CBI BST BLD SEC CLC SEN CLN SEZ CLZ SEI CLI SES CLS SEV CLV SET CLT SEH CLH BREAK NOP SLEEP WDR 
registers=r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31 R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28 R29 R30 R31
directives=.org .list .nolist .def .include .equ .byte .cseg .db .device .dseg .dw .elif .else .endif .error .eseg .exit .if .ifdef .ifndef .message .listmac .macro .endmacro .endm .set .ORG .LIST .NOLIST .DEF .INCLUDE .EQU .BYTE .CSEG .DB .DEVICE .DSEG .DW .ELIF .ELSE .ENDIF .ERROR .ESEG .EXIT .IF .IFDEF .IFNDEF .MESSAGE .LISTMAC .MACRO .ENDMACRO .ENDM .SET


[settings]
# default extension used when saving files
extension=asm

# the following characters are these which a "word" can contains, see documentation
#wordchars=_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789

# if only single comment char is supported like # in this file, leave comment_close blank
comment_open=;
comment_close=

# set to false if a comment character/string should start at column 0 of a line, true uses any
# indentation of the line, e.g. setting to true causes the following on pressing CTRL+d
	#command_example();
# setting to false would generate this
#	command_example();
# This setting works only for single line comments
comment_use_indent=true

# context action command (please see Geany's main documentation for details)
context_action_cmd=

[build_settings]
# %f will be replaced by the complete filename
# %e will be replaced by the filename without extension
# (use only one of it at one time)
compiler=avra "%f"
run_cmd=make program

# Uncomment for gavrasm
# error_regex=\[(.+),([0-9]+)\]

# Uncomment for avra
error_regex=(.+)\(([0-9]+)\) : Error

[build-menu]
FT_00_LB=_Kompilieren
FT_00_CM=avra "%f"
FT_00_WD=
EX_00_LB=_Ausführen
EX_00_CM=avrdude -p m32 -P /dev/ttyS0 -c stk500v2 -B2 -U flash:w:%e.hex:a
EX_00_WD=
