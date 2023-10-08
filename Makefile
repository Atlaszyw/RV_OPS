CROSS_COMPILE = riscv64-unknown-elf-
CFLAGS = -nostdlib -fno-builtin -march=rv32ima -mabi=ilp32 -g -Wall

QEMU = qemu-system-riscv32
QFLAGS = -nographic -smp 1 -machine virt -bios none

GDB = gdb-multiarch
CC = ${CROSS_COMPILE}gcc
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump

ASM_DIR = ./asm
SRC_DIR = ./src
INC_DIR = ./inc
BUILD_DIR = ./build

SRCS_ASM = $(wildcard $(ASM_DIR)/*.S)
SRCS_C = $(wildcard $(SRC_DIR)/*.c)

OBJS = $(SRCS_ASM:$(ASM_DIR)/%.S=%.o)
OBJS += $(SRCS_C:$(SRC_DIR)/%.c=%.o)

.DEFAULT_GOAL := all

$(shell mkdir -p $(BUILD_DIR))

all: $(BUILD_DIR)/os.elf

# start.o must be the first in dependency!
$(BUILD_DIR)/os.elf: $(patsubst %,$(BUILD_DIR)/%,$(OBJS))
	${CC} ${CFLAGS} -T link.ld -o $(BUILD_DIR)/os.elf $^
	${OBJCOPY} -O binary $(BUILD_DIR)/os.elf $(BUILD_DIR)/os.bin

$(BUILD_DIR)/%.o: $(ASM_DIR)/%.S
	${CC} ${CFLAGS} -I$(INC_DIR) -c -o $@ $<

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	${CC} ${CFLAGS} -I$(INC_DIR) -c -o $@ $<

run: all
	@${QEMU} -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	@echo "------------------------------------"
	@${QEMU} ${QFLAGS} -kernel $(BUILD_DIR)/os.elf

.PHONY: debug
debug: all
	@echo "Press Ctrl-C and then input 'quit' to exit GDB and QEMU"
	@echo "-------------------------------------------------------"
	@${QEMU} ${QFLAGS} -kernel $(BUILD_DIR)/os.elf -s -S
	# @${GDB} -tui $(BUILD_DIR)/os.elf -q -x ./gdbinit

.PHONY: code
code: all
	@${OBJDUMP} -S $(BUILD_DIR)/os.elf | less

.PHONY: clean
clean:
	rm -rf ./build
