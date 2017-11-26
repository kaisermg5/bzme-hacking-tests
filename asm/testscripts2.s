
.include "asm/macros/script_cmds.inc"

.equ LINK_DONE, 0x1
.equ BLACKSMITH_DONE, 0x2
.equ ZELDA_DONE, 0x4

.global ScriptZelda
ScriptZelda:
	enterquick
		face 0x4
		setmovementspeed 0xc0
	exitquick
	move 0x58 0x50
	face 0x4
	setbehaviourflag 0x0

	waitsignal BLACKSMITH_DONE
	move 0x70 0x68
	face 0x4
	msgbox2 0x5002 0x0
	waitmsg
	move 0x58 0x50
	face 0x4
	setbehaviourflag 0x0
	sendsignal ZELDA_DONE
	end


.global ScriptBlacksmith
ScriptBlacksmith:
	enterquick
		face 0x4
		setmovementspeed 0xc0
	exitquick
	lock
	setplayerscript ScriptLink
	move 0x88 0x50
	face 0x4
	setbehaviourflag 0x0

	waitsignal LINK_DONE
	move 0x70 0x68
	face 0x4
	msgbox2 0x5001 0x0
	waitmsg	
	move 0x88 0x50
	face 0x4
	setbehaviourflag 0x0
	sendsignal BLACKSMITH_DONE

	waitsignal ZELDA_DONE
	giveitem 0x0
	waitframes 120
	msgbox2 0x5003 0x0
	waitmsg
	release
	end


ScriptLink:
	enterquick
		setmovementspeed 0xc0
	exitquick
	move 0x70 0x68
	face 0x4
	msgbox2 0x5000 0x0
	waitmsg
	move 0x70 0x50
	face 0x4
	setbehaviourflag 0x0
	sendsignal LINK_DONE
	end
	
	
