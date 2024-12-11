BIN_FOLDER := ../../bin/osx
LIBS_FOLDER := ../../libs

SRC_FOLDER := .
BUILD_FOLDER := ./output

PROJECT_NAME := play

clean:
	rm -rf $(BUILD_FOLDER)
	mkdir -p $(BUILD_FOLDER)

build: clean
	../../bin/osx/psg_compressor --level 5 --clean "./Alex_Winston-Swing_Of_Autumn_Leaves_(2024).psg" $(BUILD_FOLDER)/music.psg.pack
	$(BIN_FOLDER)/sjasmplus --dos866 --nofakes --dirbol --outprefix=$(BUILD_FOLDER)/ \
				-i$(LIBS_FOLDER) \
				-DSNA_FILENAME=\"$(PROJECT_NAME).sna\" \
				-DBIN_FILENAME=\"$(PROJECT_NAME).bin\" \
        --lst=$(BUILD_FOLDER)/program.list \
        --fullpath $(SRC_FOLDER)/$(PROJECT_NAME).asm

run: build
	open -a 'UnrealSpeccyPortable' $(BUILD_FOLDER)/$(PROJECT_NAME).sna
