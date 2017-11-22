#! /usr/bin/env python3

import sys

if len(sys.argv) < 3:
	print('Missing parameters')
	exit(-1)

SCRIPT_END = 0xffff

COMMAND_NAMES = {
	0x0: 'nop',
	0x3: 'branch',
	0xb: 'call_function',
}

COMMAND_PARAMETERS = {
	0x3: ('-2', 2),
	0xb: (4,),
}


offset = int(sys.argv[2], base=16)
f  = open(sys.argv[1], 'rb')
f.seek(offset)

def read_number(f, byte_count= 2):
	if byte_count > 0:
		return int.from_bytes(f.read(byte_count), 'little')
	else:
		return abs(byte_count)

def format_word(num):
	return '{0:0>4}'.format((hex(num)[2::]).upper())

fail_safe = 0
while True:
	data = read_number(f)
	command = data & 0x3ff
	arg_count = (data >> 0xa) - 1

	if command not in COMMAND_NAMES:
		cmd_txt = 'cmd_{}'.format(hex(command)[2::])
	else:
		cmd_txt = COMMAND_NAMES[command]

	if data != SCRIPT_END:	
		args = []
		i = 0
		while arg_count > 0:
			if command in COMMAND_PARAMETERS:
				byte_count = COMMAND_PARAMETERS[command][i]
				i += 1
			else:
				byte_count = 2
			if isinstance(byte_count, int):
				args.append(hex(read_number(f, byte_count)))		
				arg_count -= byte_count // 2
			else:
				args.append(byte_count)
		print('\t' + cmd_txt, *args)
	else:
		print('\tend')
		break;
	if fail_safe == 1000:
		print('\n\nFailed')
		break;
	fail_safe += 1


f.close()




