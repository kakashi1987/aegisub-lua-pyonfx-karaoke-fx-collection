from pyonfx import *
import math


io = Ass("in.ass")
meta, styles, lines = io.get_data()
 
def effect(l, line):
    for syl in Utils.all_non_empty(line.syls):

        l = line.copy()
        x, y = syl.left, syl.top  
        l.start_time = line.start_time -5
        l.end_time = line.start_time + syl.start_time
        l.text = f"{{\\an7\\bord0\\shad0\\pos({x},{y})}}{syl.text}"
        io.write_line(l)

        text_to_pixel = Convert.text_to_pixels(syl)
 
        curve_val, fr = 5, 0.1 
        p_sh = Shape.rectangle()

        for i, pixel in enumerate(text_to_pixel):
            x, y = math.floor(syl.left) + pixel.x, math.floor(syl.top) + pixel.y
            alpha = ( "\\alpha" + Convert.alpha_dec_to_ass(pixel.alpha)  if pixel.alpha != 0 else "")

            t = i / len( text_to_pixel)
            angle_shift = 2 * math.pi * t  
            current_y = y + curve_val * math.sin(fr * x + angle_shift)

            l.start_time = line.start_time + syl.start_time
            l.end_time = line.start_time + syl.start_time + syl.duration/2
            l.dur = l.end_time -  l.start_time
            l.text = "{\\p1\\an7\\bord0\\shad0\\move(%f,%f,%f,%f,15,%d)%s}%s" % ( x+1, y, x+1, current_y , l.dur, alpha, p_sh)
            io.write_line(l)

            l.start_time = l.end_time
            l.end_time = line.start_time + syl.start_time + syl.duration
            l.dur = l.end_time -  l.start_time
            l.text = "{\\p1\\an7\\bord0\\shad0\\move(%f,%f,%f,%f,0,%d)%s}%s" % ( x+1, current_y, x+1, y , l.dur-20, alpha, p_sh)
            io.write_line(l)



for line in lines:
    l = line.copy()

    if not line.comment:
        effect(l, line)

io.save()
io.open_aegisub()
