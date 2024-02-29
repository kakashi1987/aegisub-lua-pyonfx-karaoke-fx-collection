from pyonfx import *
import progressbar     ## install (https://pypi.org/project/progressbar2)  ##
import random
import math


io = Ass("ED.ass")
meta, styles, lines = io.get_data()
bar = progressbar.ProgressBar(max_value=len(lines), prefix= "(Progress Bar):")

	    
def g_circle(radio,cx,cy,angle,movment):
	posx= cx + radio*math.cos(angle)
	posy= cy + radio*math.sin(angle)
 
	if not movment:
	     return posx,posy
	else:
	    posx1= cx + (radio+movment)*math.cos(angle)
	    posy1= cy + (radio+movment)*math.sin(angle)

	return posx,posy,posx1,posy1


PixP = Shape.rectangle(2, 2)

def romaji(line, l):

    for syl in (line.syls):


	    x, y = syl.center, syl.middle + 20
	    l.start_time = line.start_time
	    l.end_time = line.end_time
	    l.layer = 1
	    l.text = F"{{\\an5\\pos({x},{y})}}{syl.text}"
	    io.write_line(l)


	    rand = random.randint
	    num = math.ceil(syl.duration/1.4)
	    for r in range(num):
	        if r == 0:
	            pix = 50
	        angle=math.radians(pix)
	        R = g_circle(5 *10.4,x,y,pix,25 *4)
	        pix =pix+20*(r/pix) 

	        if line.i%2 == 0:

	            l.start_time = line.start_time+syl.start_time - 50 + r*4   	      
	            l.end_time =  l.start_time  + 700
	            l.layer = 0
	            l.effect = "FX1"
	            l.text = F"{{\\an5\\fsc250\\fad(0,200)\\bord2.5\\blur2\\3a&Hd0&\\3c&H374C8B&\\p1\\move({x},{y},{R[0]},{R[1]})}}{PixP}"
	            io.write_line(l)
 
	        else:

	            l.start_time = line.start_time+syl.start_time  + (syl.duration*(r/num) )      
	            l.end_time =  l.start_time  + 700
	            l.layer = 0
	            l.effect = "FX2"
	            l.text = F"{{\\an5\\fsc250\\fad(0,200)\\bord2.5\\blur2\\3a&Hd0&\\3c&H374C8B&\\p1\\move({x},{y},{R[0]},{R[1]})}}{PixP}"
	            io.write_line(l)


for li, line in enumerate(lines):
  if line.styleref.alignment >= 7:
    romaji(line, line.copy())

    bar.update(li)
bar.finish()
io.save()