BIN_FOLDER := ../../bin/osx
LIBS_FOLDER := ../../libs
EXT_LIBS_FOLDER := ../..

SRC_FOLDER := .
BUILD_FOLDER := ./output

PROJECT_NAME := demo

clean:
	rm -rf $(BUILD_FOLDER)
	mkdir -p $(BUILD_FOLDER)

pack_sal:
	rm -f $(BUILD_FOLDER)/*.sal
	$(BIN_FOLDER)/salvador -classic $(SRC_FOLDER)/helpcomputer0_In_the_shade_2023.scr $(BUILD_FOLDER)/helpcomputer0_In_the_shade_2023.sal

pack_upkr:
	rm -f $(BUILD_FOLDER)/*upkr.
	$(BIN_FOLDER)/upkr --z80 $(SRC_FOLDER)/prof4d_np_2015_CC_Winter.scr $(BUILD_FOLDER)/prof4d_np_2015_CC_Winter.upkr

build: clean pack_sal pack_upkr
	$(BIN_FOLDER)/sjasmplus --dos866 --nofakes --dirbol --outprefix=$(BUILD_FOLDER)/ \
				-i$(LIBS_FOLDER) \
				-i$(EXT_LIBS_FOLDER) \
				-DSNA_FILENAME=\"$(PROJECT_NAME).sna\" \
				-DBIN_FILENAME=\"$(PROJECT_NAME).bin\" \
        --lst=$(BUILD_FOLDER)/program.list \
        --fullpath $(SRC_FOLDER)/$(PROJECT_NAME).asm

run: build
	open -a 'UnrealSpeccyPortable' $(BUILD_FOLDER)/$(PROJECT_NAME).sna
