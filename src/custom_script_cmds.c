
#include <types.h>
#include <script.h>

extern void prepare_msgbox(u16 msg_indexes);

void script_simple_msgbox(void * unk_struct, struct ScriptEnv * se) {
	prepare_msgbox(se->script->data[1]);
}
