from pyonfx import *
from math import sqrt, sin, pi
import math


io = Ass("in.ass")
meta, styles, lines = io.get_data()

def bulge_effect(syl, factor, i, n):
    shape = Convert.text_to_shape(syl)
    bounding = shape.bounding()
    cx = (bounding[2] + bounding[0]) / 2
    cy = (bounding[3] + bounding[1]) / 2

    t = i / n  
    t = 1 - abs(t - 0.5) * 2
    factor *= t  

    # This func originally made by milkyjing #
    def magnifier_filter(x, y, big_x, big_y, D):
        d = math.sqrt((x - big_x)**2 + (y - big_y)**2)

        if d < D:
            ang = math.pi / 2 * math.sin(d / D)
            pct = D * math.sin(ang) / d
            new_x = int(big_x + (x - big_x) * pct)
            new_y = int(big_y + (y - big_y) * pct)
            return new_x, new_y
        else:
            return x, y

    bulged_shape = shape.map(lambda x, y: magnifier_filter(x, y, cx, cy, factor))
    return bulged_shape

def romaji(line, l):

    for syl in Utils.all_non_empty(line.syls):


        shape = Convert.text_to_shape(syl)
        l.start_time = line.start_time
        l.end_time = line.start_time + syl.start_time
        l.text = "{\\an7\\pos(%d,%d)\\bord0\\shad0\\p1}%s" % ( syl.left, syl.top,shape)
        io.write_line(l)

        FU = FrameUtility(line.start_time + syl.start_time, line.start_time + syl.end_time)
        for s, e, i, n in FU:
            l = line.copy()
            l.start_time = s
            l.end_time = e
            l.duration = e - s

            f = line.styleref.fontsize

            bulged_shape = bulge_effect(syl, f, i, n)
            l.text = "{\\an7\\pos(%d,%d)\\bord0\\shad0\\blur0.2\\p1}%s" % ( syl.left, syl.top, bulged_shape)
            io.write_line(l)

for line in lines:
   if not line.comment:
       romaji(line, line.copy())
io.save()
io.open_aegisub()
