BIN_FOLDER := ./soft/bin/osx
SRC_FOLDER := ./src
BUILD_FOLDER := ./output

PROJECT_NAME := demo

clean:
	rm -rf $(BUILD_FOLDER)
	mkdir -p $(BUILD_FOLDER)


build: clean
	$(BIN_FOLDER)/sjasmplus --dos866 --nofakes --dirbol --outprefix=$(BUILD_FOLDER)/ \
				-DSNA_FILENAME=\"$(PROJECT_NAME).sna\" \
				-DBIN_FILENAME=\"$(PROJECT_NAME).bin\" \
        --lst=$(BUILD_FOLDER)/program.list \
        --fullpath $(SRC_FOLDER)/$(PROJECT_NAME).asm

run: build
	open -a 'UnrealSpeccyPortable' $(BUILD_FOLDER)/$(PROJECT_NAME).sna
