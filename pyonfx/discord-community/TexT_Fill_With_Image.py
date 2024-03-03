from pyonfx import *
import numpy as np
from PIL import Image
import math

#https://stackoverflow.com/questions/50297272/how-to-draw-text-with-image-in-background

io = Ass("in.ass")
meta, styles, lines = io.get_data()
img_path = "image.png"   

fill_image = Image.open(img_path)
fill_image = fill_image.convert('RGBA')
fill_np = np.array(fill_image)
fill_width, fill_height = fill_image.size

def romaji(line, l, fill_np, fill_width, fill_height):
    p_sh = Shape.rectangle()
    for syl in Utils.all_non_empty(line.syls):

        l.start_time = line.start_time
        l.end_time = line.end_time

        syl_width = syl.width
        syl_height = syl.height
        scale_x = fill_width / syl_width
        scale_y = fill_height / syl_height

        for pixel in Convert.text_to_pixels(syl):
            x, y = math.floor(syl.left) + pixel.x, math.floor(syl.top) + pixel.y
            x2, y2 = x, y
            alpha = ("\\alpha" + Convert.alpha_dec_to_ass(pixel.alpha) if pixel.alpha != 0 else "")
 
            img_x = int(pixel.x * scale_x) % fill_width
            img_y = int(pixel.y * scale_y) % fill_height
 
            color = fill_np[img_y, img_x]
            color_bgr = "&H{:02X}{:02X}{:02X}&".format(color[2], color[1], color[0])

            l.text = f"{{\\p1\\an7\\1c{color_bgr}\\move({x},{y},{x2},{y2}){alpha}}}{p_sh}"
            io.write_line(l)

for line in lines:
    if not line.comment:
        romaji(line, line.copy(), fill_np, fill_width, fill_height)

io.save()
io.open_aegisub()
#ALKOON