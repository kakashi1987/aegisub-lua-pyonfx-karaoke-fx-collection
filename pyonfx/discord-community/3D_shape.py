from pyonfx import *
import math
import random
import progressbar     ## install (https://pypi.org/project/progressbar2)  ##
from pyonfx.Curve import *

io = Ass("ED.ass")
meta, styles, lines = io.get_data()
bar = progressbar.ProgressBar(max_value=len(lines), prefix= "(Progress Bar):")

def ipairs(o):
    if isinstance(o,dict):
        return o.items()
    else:
        return enumerate(o)

def romaji(line, l):

    randint = random.uniform
    pix = Shape.rectangle(2,2)
    for si, syl in ipairs(line.syls):

        x = math.floor(syl.center)  
        y = math.floor(syl.top)  +15
 
        l.start_time =  line.start_time 
        l.end_time =  line.end_time 
        l.layer= 4
        l.text = "{\\an5\\bord1\\shad0\\be0.4\\pos(%d,%d)}%s" % (x,y+5, syl.text)
        io.write_line(l)

        num = 550
        for j in range(num):

            CC =  Utils.interpolate( j/num, "&HCE761C&", "&H1CBBCE&", 1.0)

            xcos = math.cos(math.radians(j*30))*60
            xcos1 = math.cos(math.radians(j*30))*40
            ysin = math.sin(math.radians(j*30))*60
            ysin1 =  math.sin(math.radians(j*30))*40

            tab_posx = (x, x + xcos, x + xcos1, x)     
            tab_posy = (y,  y +ysin,  y +ysin1, y)      
            Points = [(tab_posx[0], tab_posy[0]+25), (tab_posx[1], tab_posy[1]),( tab_posx[2],tab_posy[2]),(tab_posx[3],tab_posy[3])]

            cur_x, cur_y = Bezier(Points,j/ num)

            tags = "\\p1\\an5\\bord0\\shad1\\be0.4"

            l.start_time = line.start_time+syl.start_time
            l.end_time = line.start_time+syl.start_time +  syl.duration

            l.text = "{%s\\move(%d,%d,%d,%d)\\1c%s\\4c%s}%s" % (tags, cur_x-syl.width/2, cur_y , cur_x+syl.width/2, cur_y, CC,CC,pix)
            l.layer= 0
            io.write_line(l)

            l.text = "{\\p1\\an5\\bord2\\blur1.5\\3a&Hdd&\\shad0\\move(%d,%d,%d,%d)\\3c%s\\1c%s}%s" % (cur_x-syl.width/2, cur_y , cur_x+syl.width/2, cur_y, CC,CC,pix)
            l.layer= 0
            io.write_line(l)
 
            if syl.i == 0:

                 x1 = cur_x-syl.width/2

                 l.start_time = line.start_time - 250 - (j-1)*2
                 l.end_time =  line.start_time+syl.start_time
                 l.layer= 0
                 l.text = "{%s\\move(%d,%d,%d,%d)\\1c%s\\4c%s}%s" % (tags, x1, cur_y , x1, cur_y,CC,CC, pix)
                 io.write_line(l)
                 l.text = "{\\p1\\an5\\bord2\\blur1.5\\3a&Hdd&\\shad0\\move(%d,%d,%d,%d)\\1c%s\\3c%s}%s" % (x1, cur_y , x1, cur_y,CC,CC, pix)
                 io.write_line(l)

            if si == 0:

                 x1 = cur_x+ line.width

                 l.start_time = line.end_time 
                 l.end_time = line.end_time+ 150 + j*2 
                 l.layer= 0
                 l.text = "{%s\\move(%d,%d,%d,%d)\\1c%s\\4c%s}%s" % (tags, x1-5, cur_y , x1-5, cur_y, CC,CC,pix)
                 io.write_line(l)
                 l.text = "{\\p1\\an5\\bord2\\blur1.5\\3a&Hdd&\\shad0\\move(%d,%d,%d,%d)\\1c%s\\3c%s}%s" % ( x1-5, cur_y , x1-5, cur_y, CC,CC,pix)
                 io.write_line(l)


for li, line in enumerate(lines):
  if line.styleref.alignment >= 7:
    romaji(line, line.copy())

    bar.update(li)
bar.finish()
io.save()
