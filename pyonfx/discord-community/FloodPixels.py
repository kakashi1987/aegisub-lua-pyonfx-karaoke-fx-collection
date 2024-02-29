from pyonfx import *
import math


def FloodPixels(line, l, io):
    io.write_line(line)

    p_sh = Shape.rectangle()
    radius = 15  #  Radius for the circular boundary
    for syl in Utils.all_non_empty(line.syls):


        Pix = Convert.text_to_pixels(syl)
        num_pixels = len(Pix)
        center_x = syl.width // 2  
        center_y =syl.height // 2  
         

        for i, pixel in enumerate(Pix):
            x, y = math.floor(syl.left) + pixel.x, math.floor(syl.top) + pixel.y
            alpha = "\\alpha" + Convert.alpha_dec_to_ass(pixel.alpha)

            new_line = l.copy()

            if (pixel.x - center_x)**2 + (pixel.y - center_y)**2 <= radius**2:
                yy = y + 60

                hex_color = "&H000000&"
            else:
                hex_color = "&H2929EF&"
                yy = y

            start_time = line.start_time  + syl.start_time
            end_time = line.end_time + syl.duration + 300
            ldur = end_time - start_time

            delay = i * (syl.duration  / len(Pix))
            
            move_params = (x, y, x, yy, delay, delay + 200)
            move_tag = "\\move(%d,%d,%d,%d,%d,%d)" % move_params


            new_line.start_time = start_time
            new_line.end_time = end_time
            new_line.text = f"{{\\bord0\\an7\\shad0\\1c{hex_color}{alpha}{move_tag}\\p1}}{p_sh}"

            io.write_line(new_line)

def main():
    io = Ass("in.ass")
    meta, styles, lines = io.get_data()

    for line in lines:
 
        FloodPixels(line, line.copy(), io)

    io.save()
    io.open_aegisub()

if __name__ == "__main__":
    main()
