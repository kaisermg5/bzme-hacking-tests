.align 2

.include "asm/macros/script_cmds.inc"


.global TestScript
TestScript:
	cmd_1
	//call_function 0x807f349
	call_function 0x8066289 //sets the sprite action when you talk to it
	//call_function 0x8066275 
	cmd_79 0xa // sets sprite hitbox
	cmd_50 0xc //sets sprite animation
	cmd_4d 0x3 
	cmd_2
goto1:
	cmd_51 // cuts script execution
	cmd_4d 0x2 // sets animation when talked from sides
	call_function 0x806622d // show message and release
	cmd_59
	cmd_4d 0x3
	cmd_50 0xc // resets animation when done talking
from1:
	branch from1 goto1 //0xffe8 // goto when_talking

	/*cmd_1
	cmd_2
	cmd_16 0xa0 0x38 0x1830
	cmd_5 0xfff6
	cmd_43
	call_function 0x807f9a5
	cmd_31 0x8
	cmd_5f 0x3207
	cmd_1c
	cmd_5 0x3e
	call_function 0x807df29
	cmd_38 0x2
	cmd_3d
	cmd_37
	call_function 0x804e865
	cmd_31 0x1e
	cmd_28 0x2 0x0
	cmd_33 0x1 0x0
	cmd_5f 0x3209
	cmd_31 0xf
	cmd_59
	cmd_44
	call_function 0x807df51
	cmd_79 0x6*/
	end

.global TestScript2
TestScript2:
	call_function 0x8066289 //these set the sprite action when you talk to it
	cmd_79 0xa // sets sprite hitbox
	cmd_50 0xc //sets sprite animation
	cmd_4d 0x3 
	cmd_2
goto2:
	cmd_51 // cuts script execution
	simple_msgbox 0x100e
from2:
	branch from2 goto2
	end
