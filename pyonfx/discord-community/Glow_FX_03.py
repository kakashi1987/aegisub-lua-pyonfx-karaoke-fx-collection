from pyonfx import *
import math
import random
import progressbar     ## Install (https://pypi.org/project/progressbar2)  ##

io = Ass("ED.ass")
meta, styles, lines = io.get_data()
bar = progressbar.ProgressBar(max_value=len(lines), prefix= "(Progress Bar):")

def pairs(o):
    if isinstance(o,dict):
        return o.items()
    else:
        return enumerate(o)


def Glow(duration):
     if duration > 50:
          time1 = random.uniform(0,duration-50)
          size1 = random.randint(25,45)
          size2 = random.randint(25,45)
          tags =  F"{{\\t({time1},{time1+1},\\fsc{size1})\\t({time1+2},{time1+100},\\fscx20\\fscy20)\\t({time1+101},{time1+102},\\fscx{size2}\\fscy{size2})\\t({time1+103},{time1+150},\\fscx20\\fscy20)\\t({time1+151},{time1+180},\\fscx{size2}\\fscy{size2})\\t({time1+181},{time1+205},\\fscx20\\fscy20)}}"
          return tags
     else:
          return ""


def romaji(line, l):

    for char in Utils.all_non_empty(line.chars):

        Frames = 1000 / 23.976
        duration = 10* Frames
        time_t1 = 1     
        x, y = char.center, char.middle


        l.start_time =  line.start_time + char.i * time_t1 * Frames / 10 - time_t1 * Frames / 10 - duration/ 1.2 -10
        l.end_time =  line.start_time + char.i * time_t1 * Frames / 10 - time_t1 * Frames / 10 -10
        l.layer = 2
        l.text = "{\\an5\\move(%d,%d,%d,%d)\\fad(100,0)\\org(%d,%d)\\t(\\fr-750)\\bord1\\shad0}%s" % (x+50,y,x,y-10, x-40,y+20, char.text)
        io.write_line(l)

        l.start_time =  line.start_time + char.i * time_t1 * Frames / 10 - time_t1 * Frames / 10 -10
        l.end_time =  line.end_time - ( len(line.chars) - char.i -1) * time_t1 * Frames/ 10 + time_t1 * Frames / 10 + 200
        l.layer = 2
        l.text = "{\\an5\\pos(%d,%d)\\bord1\\shad0}%s" % (x,y, char.text)
        io.write_line(l)

        l.start_time =  line.end_time - ( len(line.chars) - char.i -1) * time_t1 * Frames/ 10 + time_t1 * Frames / 10 + 200
        l.end_time =  line.end_time - ( len(line.chars) - char.i -1) * time_t1 * Frames / 10 + time_t1 * Frames / 10 + duration/ 1.2  + 200
        l.layer = 1
        l.text = "{\\an5\\move(%d,%d,%d,%d)\\fad(0,100)\\org(%d,%d)\\t(\\fr-750)\\bord1\\shad0}%s" % (x,y,x-50,y, x+40,y+20, char.text)
        io.write_line(l)

    star = "m 30 23 b 24 23 24 33 30 33 b 36 33 37 23 30 23 m 35 27 l 61 28 l 35 29 m 26 27 l 0 28 l 26 29 m 29 23 l 30 0 l 31 23 m 29 33 l 30 56 l 31 33 l 31 33 "
    for li, syl in pairs(line.syls):


        ## you could use char with pixel it might be good ##
        pix_num = Convert.text_to_pixels(syl)
        for pix in range(len(pix_num)):

            ran_pix = random.randint(-pix, pix)

            xr =  math.floor(syl.left) + pix_num[ran_pix].x  
            yr =  math.floor(syl.top) + pix_num[ran_pix].y  
 
            if random.randint(0,25) == 1:

                     Def_tags = "\\p2\\an5\\shad0\\bord2\\blur2\\3a&HCC&\\fscx20\\fscy20\\1c&HFFFFFF&"
                     c3 = ["&H9E2E54&","&H1516EC&","&H1570EC&"]
                     c3 = c3[random.randint(0, len(c3)) - 1]

                     pnum  = (pix) / len(pix_num)
                     lops_dur  = Utils.interpolate(pnum, 0,  syl.duration)

                     l.start_time = line.start_time + syl.start_time + lops_dur
                     l.end_time =  line.start_time +  syl.start_time + lops_dur +  250

                     l.dur = l.end_time - l.start_time
                     lops_time  = Utils.interpolate(pnum, 0, l.dur)
                     l.layer = 2
                     l.text = "{%s\\3c%s\\pos(%d,%d)}%s%s" % (Def_tags,c3, xr,yr,Glow(lops_time),star)
                     io.write_line(l)


                     l.start_time = line.start_time +  syl.start_time + lops_dur + 250
                     l.end_time =  line.start_time +  syl.start_time + lops_dur + 650  
                     l.dur = l.end_time - l.start_time
                     lops_time  = Utils.interpolate(pnum, 20, l.dur)
                     frand = random.randint(80,120)
                     l.layer = 2                 
                     l.text = "{%s\\fad(0,%d)\\1c&HFFFFFF&\\3c%s\\move(%d,%d,%d,%d)}%s%s" % (Def_tags,frand, c3, xr,yr,xr,yr+frand, Glow(lops_time),star)
                     io.write_line(l)


for li, line in pairs(lines):
  if line.styleref.alignment >= 7:
    romaji(line, line.copy())

    bar.update(li)
bar.finish()
io.save()
