#-------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITARM)),)
$(error Please set DEVKITARM in your environment. export DEVKITARM=/path/to/devkitARM)
endif

include $(DEVKITARM)/base_tools

#-------------------------------------------------------------------------------
# Tools
PYTHON3 = python3
TXT_HEADER_MAKER = $(PYTHON3) tools/create_texttable_header.py
POKERUBY_TOOLS := tools/pokeruby
PREPROC = $(POKERUBY_TOOLS)/preproc/preproc


#-------------------------------------------------------------------------------

export ROM_CODE := BZME

export BUILD := build
export HEADER_DIR := include
export SRC := src
export ASM := asm
export ALL_TXT_FILE := $(BUILD)/fulltextable.s
export TXTS_DIR := data/texts
export TXT_TABLE_CONFIG := $(TXTS_DIR)/table_order.cfg
export BASE_PREFIX := baserom
export BASEROM := $(BASE_PREFIX).gba
export BASEDATA := $(BASE_PREFIX).s
export OUTPUT := game/rom.gba
export RELOCATABLE := $(BUILD)/relocatable.o
export PATCHES := $(BUILD)/patches.inc
export FREE_SPACE_OFFSET := 0x08de7db0
export EMPTY := $(BUILD)/empty.s

export ARMIPS ?= armips
export LD := $(PREFIX)ld

export ASFLAGS := -mthumb
	
export INCLUDES := -I $(HEADER_DIR)
export WARNINGFLAGS :=	-Wall -Wno-discarded-array-qualifiers \
	-Wno-int-conversion
export CFLAGS := -mthumb -mno-thumb-interwork -mcpu=arm7tdmi -mtune=arm7tdmi \
	-march=armv4t -mlong-calls -fno-builtin $(WARNINGFLAGS) $(INCLUDES) \
	-O -finline 

export ARMIPS_FLAGS := -strequ input_game $(BASEROM) -strequ relocatable_obj $(RELOCATABLE) \
				-strequ asm_include $(PATCHES) -equ free_space_offset $(FREE_SPACE_OFFSET)
	

export LDFLAGS := -r -T linker.ld -T $(ROM_CODE).ld



export INCLUDES_GENERATOR := sh tools/includes_generator.sh

#-------------------------------------------------------------------------------
	
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# Sources
C_SRC := $(call rwildcard,$(SRC),*.c)
ASM_SRC := $(call rwildcard,$(ASM),*.s)

ASM_PATCHES :=  $(call rwildcard,$(ASM),*.sinc)


# Texts
TXT_INCS := $(call rwildcard,$(TXTS_DIR),*.inc)
ifneq ($(strip $(TXT_INCS)),)
ASM_SRC := $(ASM_SRC) $(ALL_TXT_FILE)
endif

# Binaries
ifeq ($(strip $(ASM_SRC) $(C_SRC)),)
ASM_SRC := $(EMPTY)
endif
C_OBJ := $(C_SRC:%.c=$(BUILD)/%.o)
ASM_OBJ := $(ASM_SRC:%.s=$(BUILD)/%.o)


RELOCATABLE_OBJ := $(C_OBJ) $(ASM_OBJ)

BINARIES := $(RELOCATABLE)

#-------------------------------------------------------------------------------

.PHONY: all clean

all: $(OUTPUT) 

delete_rom:
	rm -f $(OUTPUT)

again: delete_rom $(OUTPUT)

$(OUTPUT): $(BASEDATA) $(PATCHES) $(BINARIES)
	@mkdir -p $(@D)
	$(ARMIPS) $(BASEDATA) -sym offsets.txt -strequ output_game $@ $(ARMIPS_FLAGS)

clean:
	rm -rf build $(OUTPUT)

$(PATCHES): $(ASM_PATCHES)
	@mkdir -p $(@D)
	$(INCLUDES_GENERATOR) $^ > $@

$(RELOCATABLE): $(ROM_CODE).ld $(RELOCATABLE_OBJ) 
	$(LD) $(LDFLAGS) -o $@ $(RELOCATABLE_OBJ) 


$(EMPTY):
	@mkdir -p $(@D)
	@echo "//empty" > $@

$(ALL_TXT_FILE): $(TXT_INCS) $(TXT_TABLE_CONFIG)
	@mkdir -p $(@D)
	$(TXT_HEADER_MAKER) $(TXT_TABLE_CONFIG) $@

$(BUILD)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ -c $<

$(BUILD)/%.o: %.s
	@mkdir -p $(@D)
	$(PREPROC) $< charmap.txt | $(AS) $(ASFLAGS) -o $@

	
	
	
