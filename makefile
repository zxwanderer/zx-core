BUILD_FOLDER := output

clean:
	rm -rf $(BUILD_FOLDER)
	mkdir -p $(BUILD_FOLDER)

make_scr:
	python3 ./engine/bin/cross-platform/png2scr.py -i ./data/tiles/tiles_mod.png -o ./$(BUILD_FOLDER)/tiles.scr

make_map:
	python3 ./engine/bin/cross-platform/tiled2bin.py -i ./data/map/cell.tmx -o ./$(BUILD_FOLDER)/map.bin

make_tileset: make_scr
	python3 ./engine/bin/cross-platform/scr2spr.py --width 2 --height 2 --color True --count 191 -i ./$(BUILD_FOLDER)/tiles.scr -o ./$(BUILD_FOLDER)/tiles.bin

compile_parts: make_map
	./engine/bin/osx/sjasmplus --dos866 --nofakes --dirbol --outprefix=./$(BUILD_FOLDER)/ \
        --lst=./$(BUILD_FOLDER)/program.list \
        --fullpath ./parts.asm

pack_sal:
	rm -f ./$(BUILD_FOLDER)/*.sal
	./engine/bin/osx/salvador -classic ./$(BUILD_FOLDER)/static.bin ./$(BUILD_FOLDER)/static.bin.sal
	./engine/bin/osx/salvador -classic ./$(BUILD_FOLDER)/dynamic.bin ./$(BUILD_FOLDER)/dynamic.bin.sal

make_sna: clean make_tileset compile_parts pack_sal
	./engine/bin/osx/sjasmplus --dos866 --nofakes --dirbol --outprefix=./$(BUILD_FOLDER)/ \
        --lst=./$(BUILD_FOLDER)/program.list \
        --fullpath ./make_sna.asm

run_sna: make_sna
	open -a 'UnrealSpeccyPortable' ./$(BUILD_FOLDER)/cell3326.sna
