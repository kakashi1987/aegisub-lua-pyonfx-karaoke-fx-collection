
## Basic Flood Fill Effect \ ALKOON \ (https://en.wikipedia.org/wiki/Flood_fill} ##

from pyonfx import *
import math,random
from collections import deque

io = Ass("in.ass")
meta, styles, lines = io.get_data()


def flood_fill_from_pixel(line, io, pixels, filled, syl, fill_order, start_x, start_y):
    sorted_pixels = sorted(pixels, key=lambda p: (p.y, p.x))
    to_fill = deque([(int(start_x), int(start_y))])

    while to_fill:
        x, y = to_fill.popleft()

        if (x, y) in filled:
            continue

        if not any(p.x == math.floor(x - int(syl.left)) and p.y == math.floor(y - int(line.top)) for p in pixels):
            continue

        filled.add((x, y))
        fill_order.append((x, y))


        for dx, dy in [(0, -1), (1, 0), (0, 1), (-1, 0)]:  # Recursive flood fill with 4 directions, see wiki link above for more info
        #for dx, dy in [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1),  (0, 1), (1, 1)]: # Recursive flood fill with 8 directions, see wiki link above for more info
            new_x, new_y = int(x + dx), int(y + dy)
            if (new_x, new_y) not in filled:
                to_fill.append((new_x, new_y))


def animate_pixels(fill_order, line, pixel, syl, io, p_sh, pixels):

    l = line.copy()
    l.start_time = line.start_time -50 + syl.i*40
    l.end_time = line.end_time + syl.i*40  
    l.text = f"{{\\an5\\shad0\\bord1.5\\blur1.5\\fad(100,100)\\pos({int(syl.x)},{int(syl.y+22)})}}{syl.text}"
    io.write_line(l)

    base_time = line.start_time + syl.start_time
    pixel_duration = syl.duration / len(fill_order)

    for i, (x, y) in enumerate(fill_order):

        start_time = base_time + i * pixel_duration
        end_time = start_time + pixel_duration

        pixel = next((p for p in pixels if int(p.x) + int(syl.left) == x and int(p.y) + int(line.top) == y), None)
        alpha =  ("1a" + Convert.alpha_dec_to_ass(pixel.alpha) if pixel.alpha != 0 else "00")

        l = line.copy()
        l.start_time = start_time
        l.end_time = end_time + 300
        l.text = f"{{\\an7\\fad(70,70)\\shad0\\3a&HF0&\\bord1\\blur1\\{alpha}\\3c&HFFFFFF&\\1c&H000000&\\pos({int(x)},{int(y)})\\p1}}{p_sh}" 
        io.write_line(l)


def flood_fill(line, io):
    filled = set()
    fill_order = []
    p_sh = Shape.rectangle(1, 1)

    for syl in Utils.all_non_empty(line.syls):
        print(f"Processing syllable: {syl.text}")
        pixels = Convert.text_to_pixels(syl)

        for pixel in pixels:
            pixel_pos = (int(pixel.x) + int(syl.left), int(pixel.y) + int(line.top))
            if pixel_pos not in filled:
                flood_fill_from_pixel(line, io, pixels, filled, syl, fill_order, *pixel_pos)

        animate_pixels(fill_order, line, pixel,  syl, io, p_sh,  pixels)

        fill_order.clear()
    return filled


for line in lines:
    if not line.comment:
        filled_for_line = flood_fill(line, io)

io.save()
io.open_aegisub()