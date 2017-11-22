
.macro nop
.2byte 0x400
.endm

.macro cmd_1
.2byte 0x401
.endm

.macro cmd_2
.2byte 0x402
.endm

.macro branch from to
.2byte 0x803
.2byte (\to - \from - 2) 
.endm

.macro cmd_5 par
.2byte 0x805
.2byte \par
.endm

.macro call_function func_ptr
.2byte 0xc0b
.4byte \func_ptr
.endm

.macro cmd_16 par1 par2 par3
.2byte 0x1016
.2byte \par1
.2byte \par2
.2byte \par3
.endm

.macro cmd_1c par
.2byte 0x81c
.2byte \par
.endm

.macro cmd_28 par1 par2
.2byte 0xc28
.2byte \par1
.2byte \par2
.endm

.macro cmd_31 par
.2byte 0x831
.2byte \par
.endm

.macro cmd_33 par1 par2
.2byte 0xc33
.2byte \par1
.2byte \par2
.endm

.macro cmd_37
.2byte 0x437
.endm

.macro cmd_38 par
.2byte 0x838
.2byte \par
.endm

.macro cmd_3d
.2byte 0x43d
.endm

.macro cmd_43
.2byte 0x443
.endm

.macro cmd_44
.2byte 0x444
.endm

.macro cmd_4d par
.2byte 0x84d
.2byte \par
.endm

.macro cmd_50 par
.2byte 0x850
.2byte \par
.endm

.macro cmd_51
.2byte 0x451
.endm

.macro cmd_59
.2byte 0x459
.endm

.macro cmd_5d msg_num par2 
.2byte 0xc5d
.2byte \msg_num
.2byte \par2
.endm

.macro cmd_5f par
.2byte 0x85f
.2byte \par
.endm

.macro cmd_61 par
.2byte 0x861
.2byte \par
.endm

.macro cmd_64
.2byte 0x464
.endm

.macro cmd_79 par
.2byte 0x879
.2byte \par
.endm

.macro end
.2byte 0xffff
.endm


.macro simple_msgbox msg_indexes
.2byte 0x8ca
.2byte \msg_indexes
.endm
