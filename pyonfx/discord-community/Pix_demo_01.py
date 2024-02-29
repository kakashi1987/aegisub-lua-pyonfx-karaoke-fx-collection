from pyonfx import *
import random, math

p_sh = Shape.rectangle()

def effect(line, l, io):
    l.layer = 1

    for syl in Utils.all_non_empty(line.syls):
        Pix = Convert.text_to_pixels(syl)
        num_pixels = len(Pix)
        step_2_move_down = 40  

        x, y = math.floor(syl.left), math.floor(syl.top)  
        l.start_time = line.start_time -5
        l.end_time =  line.start_time + syl.start_time  
        l.text = f"{{\\an7\\bord0\\shad0\\pos({x},{y})}}{syl.text}"
        io.write_line(l)


        for i, pixel in enumerate(Pix):
            x, y = math.floor(syl.left) + pixel.x, math.floor(syl.top) + pixel.y

            alpha = "\\alpha" + Convert.alpha_dec_to_ass(pixel.alpha)     

            l.start_time = line.start_time + syl.start_time  
            l.end_time = l.start_time + syl.duration  + 15

            pixel_start_time = (syl.duration / num_pixels) * i
            pixel_end_time = pixel_start_time + (syl.duration / num_pixels)
            
            y_end = y + step_2_move_down
            move_tag = "\\move({},{},{},{},{},{})".format(x, y, x, y_end, pixel_start_time, pixel_end_time)

            l.text = f"{{\\bord0\\an7\\shad0\\1c&HFFFFFF&{alpha}{move_tag}\\p1}}{p_sh}"
            io.write_line(l)

def main():
    io = Ass("in.ass")
    meta, styles, lines = io.get_data()

    for line in lines:

        effect(line, line.copy(), io)

    io.save()
    io.open_aegisub()

if __name__ == "__main__":
    main()
