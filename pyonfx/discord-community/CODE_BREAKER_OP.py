from pyonfx import *
import random
from math  import *


io = Ass("CODE BREAKER OP.ass")
meta, styles, lines = io.get_data()

circle = Shape.ellipse(5, 7)

def AdvInt(a):      
    if a >= 0 and a - int(a) < 0.8:
        return int(a)
    elif a >= 0 and a - int(a) >= 0.8:
        return int(a) + 1
    elif a < 0 and a - int(a) <= -0.8:
        return int(a) - 1
    else:             
        return int(a)


def RandCir(a, b, r1, r2):       
    R = random.randint(r1, r2)
    theta = random.randint(0, 2 * 314) / 100 
    x = AdvInt(R * cos(theta) + a)
    y = AdvInt(R * sin(theta) + b)
    return (x, y)

def romaji(line, l):

	off_x = 45
	off_y = 25

	for syl in Utils.all_non_empty(line.syls):

		l.layer = 0
		l.start_time = line.start_time + 25*syl.i - 300
		l.end_time = line.start_time + syl.start_time
		l.dur = l.end_time - l.start_time

		l.text = "{\\an5\\move(%.3f,%.3f,%.3f,%.3f,0,%d)\\3c&H1C0B83&\\bord2.3\\be1\\fad(%d,0)}%s" % (
			syl.center +(syl.i / 2)*off_x, syl.middle + (syl.i / 2)*off_y, syl.center, syl.middle, 300, 300, syl.text)
		#io.write_line(l)

		x, y = syl.center,  syl.middle +25
		rand = random.randint
		num = 50 

		for h in range(num):

		     R = RandCir(x, y, 17, 40)
		     C = rand(-400,400)
		     F =  rand(-20,10)

		     l.layer = random.randint(0,3)
		     l.start_time = line.start_time + syl.start_time
		     l.end_time = line.start_time + syl.start_time +syl.duration/1.4 + 100
		     l.dur = l.end_time - l.start_time
		     l.text = "{\\an5\\move(%d,%d,%d,%d)\\1c&H0000FF&\\shad1\\4c&H04044B&\\fscx%d\\fscy%d\\bord0\\p4}%s" % (x,y,R[0],R[1], 
                                           100+C, 100+C, circle)
		     io.write_line(l)

		     A = [rand(0,0), rand(0,0), rand(0,0), rand(100,3000), rand(0,1000)]
		     D = [rand(+0,+100)/100, rand(0,0)]
		     G = D[rand(-1,1)]
		     E = A[rand(0,4)]

		     l.start_time = l.end_time
		     l.end_time = line.start_time + syl.start_time +syl.duration/1.2 + 700  
		     l.text = "{\\an5\\pos(%d,%d)\\1c&H0000FF&\\shad1\\4c&H04044B&\\fscx%d\\fscy%d\\t(\\fscx%d\\fscy%d)\\bord0\\fad(0,%d)\\p4}%s" % (R[0],R[1], 
                                           100+C, 100+C, 100+C+G,100+C+E, 200+rand(100,100), circle)
		     io.write_line(l)
 


for line in lines:
	if line.styleref.alignment >= 7:
		romaji(line, line.copy())

io.save()
io.open_aegisub()