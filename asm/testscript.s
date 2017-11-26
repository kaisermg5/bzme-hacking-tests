.align 2

.include "asm/macros/script_cmds.inc"


.global TestScript
TestScript:
	enterquick
	//callfunction 0x807f349
	callfunction 0x8066289 //sets the sprite action when you talk to it
	//callfunction 0x8066275 
	setbehaviourflag 0xa // sets sprite hitbox
	cmd_50 0xc //sets sprite animation
	cmd_4d 0x3 
	exitquick
to1:
	cmd_51 // cuts script execution
	cmd_4d 0x2 // sets animation when talked from sides
	callfunction 0x806622d // show message and release
	waitmsg
	cmd_4d 0x3
	cmd_50 0xc // resets animation when done talking
from1:
	branch to1 //0xffe8 // goto when_talking

	enterquick
	exitquick
	cmd_16 0xa0 0x38 0x1830
	branch_ifzero_explicit 0xfff6
	lock
	callfunction 0x807f9a5
	waitframes 0x8
	cmd_5f 0x3207
	cmd_1c
	branch_ifzero_explicit 0x3e
	callfunction 0x807df29
	cmd_38 0x2
	cmd_3d
	cmd_37
	callfunction 0x804e865
	waitframes 0x1e
	sendsignal 0x2
	waitsignal 0x1
	cmd_5f 0x3209
	waitframes 0xf
	waitmsg
	release
	callfunction 0x807df51
	setbehaviourflag 0x6
	end

.global TestScript2
TestScript2:
	enterquick
	//callfunction 0x8066289 //these set the sprite action when you talk to it
	setbehaviourflag 0xa // sets sprite hitbox
	cmd_50 0xc //sets sprite animation
	//cmd_4d 0x3
	addaction_talk
	exitquick 
to2:
	//cmd_51 // cuts script execution
	checknewactions
from2:
	branch_ifzero to2

	//msgbox2 0x5000 0x0
	simple_msgbox 0x5000
	waitmsg
from2_2:
	branch to2 
	end


.global ScriptZeldaOriginal
ScriptZeldaOriginal:
	enterquick
		face 0x2
		setmovementspeed 0x100
		callfunction 0x807f349
	exitquick

	waitsignal 0x4
	setbehaviourflag 0x4
	faceplayer
	waitsignal 0x4
	faceplayer
	waitsignal 0x4
	faceplayer
	faceme
	setbehaviourflag 0x1
	msgbox2 0x100a 0x0
	waitmsg
	setbehaviourflag 0x0
	sendsignal 0x8
	waitsignal 0x4
	faceme
	setbehaviourflag 0x1
	faceme
	face 0xa // up
	waitframes 60
	msgbox2 0x100d 0x0
	waitmsg
	setbehaviourflag 0x0
	move 0x28 0x60
	move 0x0 0x60
	callfunction 0x80536a9			// shows how Zelda leaves the house
	waitframes 0x1e

	enterquick
		setflag 0x13
		//clearflag 0x13
		callfunction 0x807df51
		callfunction 0x80791d1
		release
	exitquick
	end

.global ScriptBlacksmithOriginal
ScriptBlacksmithOriginal:
	enterquick
		face 0x6
		setmovementspeed 0x80
		addaction_talk						// sets  sprite action when talked to
		callfunction 0x807f349
	exitquick

	checkflag 0x13
from3:
	branch_ifnotzero to3
	lock2
	waitframes 0xa
	lock
	setplayerscript ScriptLink
	callfunction 0x807df29
	waitsignal 0x8
	move 0x80 0x5c
	face 0x6
	setbehaviourflag 0x0
	waitframes 0xf
	setbehaviourflag 0x1
	msgbox2 0x1009 0x0
	set_unk_important_flags_two
	waitmsg
	setbehaviourflag 0x0
	sendsignal 0x4
	waitsignal 0x8
	faceme
	setbehaviourflag 0x1
	msgbox2 0x100b 0x0
	waitmsg
	setbehaviourflag 0x0
	sendsignal 0x2
	waitsignal 0x8
	move 0x7c 0x5c
	waitframes 0xf
	setbehaviourflag 0xd
	move 0x84 0x5c
	face 0x6
	setbehaviourflag 0xc
	setbehaviourflag 0x0
	sendsignal 0x2
	waitsignal 0x8
	callfunction 0x8053251
	giveitem 0x34
	cmd_34
	set_unk_important_flags_two
	setbehaviourflag 0x1
	msgbox2 0x100c 0x0
	waitmsg
	setbehaviourflag 0x0
	sendsignal 0x4
to3:
	setbehaviourflag 0xa
to4:
	checknewactions
from4:
	branch_ifzero to4
	lock
	faceplayer
	msgbox 0x100e
	release
from4_2:
	branch to4 
	end


ScriptLink:
	enterquick
		set_unk_important_flags_two
		setmovementspeed 0xc0
	exitquick
	sendsignal 0x4
	setbehaviourflag 0x4
	waitframes 0x3c
	move 0x40 0x60
	move 0x60 0x68
	sendsignal 0x4
	setbehaviourflag 0x0
	set_unk_important_flags_zero
	waitframes 0xf
//	cmd_7b 0x94
	setbehaviourflag 0x0
	waitframes 0x1e
	sendsignal 0x8
	waitsignal 0x2
	move 0x70 0x5c
	set_unk_important_flags_two
	setbehaviourflag 0x0
	waitframes 0xf
	sendsignal 0x8
	waitsignal 0x2
	sendsignal 0x8
	end


