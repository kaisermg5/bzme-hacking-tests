.include "asm/macros/script_cmds.inc"

.global ScriptZelda2
ScriptZelda2:
	enterquick
		face 0x2		// face down
		setmovementspeed 0x100 	// sets movement speed
	exitquick
	waitsignal 0x4
	setbehaviourflag 0x4 			// exclamation
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
	face 0x2 					// face right?
	msgbox2 0x100d 0x0
	waitmsg
	setbehaviourflag 0x0
	move 0x28 0x60
	move 0x0 0x60
	callfunction 0x80536a9		// shows how Zelda leaves the house
	waitframes 0x1e

	enterquick
		setflag 0x13 			// sets a flag that prevents this from loading again
		//callfunction 0x807df51 	
		//callfunction 0x80791d1
		release
	exitquick
	end

.global ScriptBlacksmith2
ScriptBlacksmith2:
	enterquick
		face 0x2				// face down
		setmovementspeed 0x80 	
		addaction_talk					// sets  sprite action when talked to
	exitquick

	
	setbehaviourflag 0xa
	setbehaviourflag 0xd
	waitframes 360
	setbehaviourflag 0x1
	waitframes 360
	/*setbehaviourflag 0xd
	waitframes 360
	setbehaviourflag 0x1
	waitframes 360*/

	lock
	setplayerscript ScriptLink2
	waitsignal 0x8
	move 0x80 0x5c
	face 0x6 					// face left
	setbehaviourflag 0x0					// do not move your feet! 
	setbehaviourflag 0x1
	msgbox2 0x1009 0x0
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
	move 0x7c 0x5c 				// step forward
	waitframes 0xf
	setbehaviourflag 0xd
	move 0x84 0x5c 				// step back
	face 0x6					// face left
	setbehaviourflag 0xc
	setbehaviourflag 0x0					// do not move your feet! 
	sendsignal 0x2
	waitsignal 0x8
//	giveitem 0x34				// it also unasigns the player script???
	giveitem 0x1
	cmd_34
	set_unk_important_flags_two
	setbehaviourflag 0x1
	msgbox2 0x100c 0x0
	waitmsg
	setbehaviourflag 0x0
	sendsignal 0x4
	setbehaviourflag 0xa					// makes the sprite solid
to3:
	checknewactions 						// wait for interaction? (setted with addaction_talk)
from3:
	branch_ifzero to3					// fails if you asign a script to the player
	lock
	faceplayer
	msgbox 0x100e
	release
from3_2:
	branch to3
	end



ScriptLink2:
	enterquick
		setmovementspeed 0xc0
	exitquick

	sendsignal 0x4
	setbehaviourflag 0x4			// exclamation
	waitframes 0x3c	
	move 0x40 0x60
	move 0x60 0x68
	sendsignal 0x4	
	setbehaviourflag 0x0			// do not move your feet! 
	sendsignal 0x8
	waitsignal 0x2
	move 0x70 0x5c
	setbehaviourflag 0x0			// do not move your feet! 
	sendsignal 0x8
	waitsignal 0x2
	sendsignal 0x8
	end
