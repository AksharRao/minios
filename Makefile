ASM:=nasm

SRC_DIR:=src
BUILD_DIR:=build

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	@cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
	@truncate -s 1440k $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	# Basically the following command is an instruction to create a "flat binary" ( -f bin) file \
	# from the source assembly file and output into main.bin in build directory
	@$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin
