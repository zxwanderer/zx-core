# Hardcode exporter from TIled map first layer data to defb asm
# example:
# python3 tsx2asm.py -i tiles.tmx -o tiles_types.asm

import argparse
import sys
from xml.dom.minidom import parse

def createparser():
    myparser = argparse.ArgumentParser()
    myparser.add_argument('-i', '--input', type=str)
    myparser.add_argument('-o', '--output', default='cells.asm', type=str)
    return myparser

# # Загрузка и парсинг XML-файла
# dom = parse('./data/maps/tiles_many.tsx')  # Укажите путь к вашему XML-файлу
# root = dom.documentElement

# # Открываем выходной файл для записи
# with open('spr_cells.txt', 'w') as output_file:
#     # Извлечение информации о тайлах
#     tiles = root.getElementsByTagName('tile')
#     for tile in tiles:
#         tile_id = tile.getAttribute('id')
#         tile_id_hex = f"#{int(tile_id):X}"
#         tile_type = tile.getAttribute('type')
#         # Записываем данные в файл в формате id:type
#         output_file.write(f"DEFINE_SPR_CELL {tile_id_hex}, {tile_type}\n")

# print("Данные успешно записаны в файл spr_cells.txt")


def main():
    parser = createparser()
    namespace = parser.parse_args(sys.argv[1:])
    dom = parse(namespace.input)
    root = dom.documentElement

    with open(namespace.output, "w") as fh:
        tiles = root.getElementsByTagName('tile')
        for tile in tiles:
            tile_id = tile.getAttribute('id')  # Получаем id как строку
            tile_id_int = int(tile_id)  # Преобразуем id в целое число
            # tile_id_hex = f"#{int(tile_id):X}"
            tile_id_hex = f"#{tile_id_int:02X}"
            tile_type = tile.getAttribute('type')
            # Записываем данные в файл в формате id:type
            fh.write(f"DEFINE_SPR_CELL {tile_id_hex}, {tile_type}\n")

if __name__ == '__main__':
    main()
