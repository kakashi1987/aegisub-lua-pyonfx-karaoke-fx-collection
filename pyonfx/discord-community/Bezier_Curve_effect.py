from pyonfx import *
from pyonfx.Bezier import Bezier
import numpy as np
import progressbar     ## install (https://pypi.org/project/progressbar2)  ##
import random
import math


io = Ass("ED.ass")
meta, styles, lines = io.get_data()
bar = progressbar.ProgressBar(max_value=len(lines), prefix= "(Progress Bar):")

star = "m 1 1 l 50 43 l 100 0 l 57 50 l 100 100 l 50 57 l 0 100 l 43 50 l 1 1 "
 
def romaji(line, l):

	for syl in (line.syls):
		x, y = syl.center,  syl.middle  + 15

		l.layer = 0
		l.start_time = line.start_time + syl.i* 50 - 400
		l.end_time = line.end_time  
		l.dur = l.end_time - l.start_time

		l.text = "{\\an5\\move(%.3f,%.3f,%.3f,%.3f,0,%d)\\frz360\\t(0,350,\\frz0)\\bord1\\fad(200,0)}%s" % (x +(syl.i / 2), y + (syl.i / 2), x, y, 400, syl.text)
		io.write_line(l)


		# Note: If syl.dur > 80 you most change P values =) #

		P = np.array([[x  -(syl.width/2 ), y], [x , y - syl.height *1.4 + (0.5*syl.duration/4)],[x + (syl.width/2 ),y]])
 
 
		num = int(syl.width*2)
		step_size = ( 1 / num)


		randint = random.randint
		for b in range(num):

		          Syl_partic = syl.duration *(b/num)
		          x, y = Bezier.Point( b * step_size , P)
		          l.start_time = line.start_time + syl.start_time + Syl_partic
		          l.end_time = l.start_time  + syl.duration/2  

		          if syl.i%2 == 0:
		               frzz = 260*((b/num))
		          else:
		               frzz = -260*((b/num))

		          l.text = "{\\an5\\pos(%d,%d)\\bord2\\blur2\\3a&Hd0&\\fscx80\\fscy80\\frz%d\\t(\\fscx30\\fscy30)\\fad(0,200)\\1cH&FFFFFF&\\3c&H2E2FF0&\\p3}%s" % (x,y,frzz, star)
		          io.write_line(l)
		          l.layer = 2
		          l.text = "{\\an5\\pos(%d,%d)\\bord0\\fscx85\\fscy85\\frz%d\\t(\\fscx35\\fscy35)\\fad(0,200)\\1cH&FFFFFF&\\3c&H2E2FF0&\\p3}%s" % (x,y,frzz, star)
		          io.write_line(l)


		          if randint(0,2) == 0 :

		                l.layer = 3
		                l.start_time = l.end_time - 20
		                l.end_time = l.start_time + b + randint(600,800) 
		                l.text = "{\\an5\\move(%d,%d,%d,%d)\\bord2\\blur2\\3a&H90&\\fscx40\\fscy40\\t(\\fscx20\\fscy20)\\fad(0,%d)\\frz%d\\1cH&FFFFFF&\\3c&H2E2FF0&\\p3}%s" % (
		                x,y,x+randint(-5,5),y+randint(20,70), randint(400,600), frzz, star)
		                io.write_line(l)

		                l.layer = 4
		                l.text = "{\\an5\\move(%d,%d,%d,%d)\\bord0\\fscx45\\fscy45\\t(\\fscx25\\fscy25)\\fad(0,%d)\\frz%d\\1cH&FFFFFF&\\3c&H2E2FF0&\\p3}%s" % (
		                x,y,x+randint(-5,5),y+randint(20,70),randint(400,600) , frzz, star)
		                io.write_line(l)


for li, line in enumerate(lines):
  if line.styleref.alignment >= 7:
    romaji(line, line.copy())

    bar.update(li)
bar.finish()
io.save()