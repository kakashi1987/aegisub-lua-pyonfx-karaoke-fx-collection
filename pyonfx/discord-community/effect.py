# Made by moi15moi

from pyonfx import *
from sympy import *
from pprint import pprint

import math

io = Ass("184.ass")
meta, styles, lines = io.get_data()

# function height
h = 25

def RomanjiSonGoku(line, l):
    global h

    if(h<0):
        h = h * -1

    #Lead in
    FU = FrameUtility(line.start_time - 500, line.start_time)
    distanceEnterNextSyllable = getDistanceBetweenNextSyllable(line, -1)
    writeLine(l, FU, line.syls[0].center - distanceEnterNextSyllable, line.syls[0].middle, distanceEnterNextSyllable, "leadIn")

    # Main Effect

    # On ne veut pas prendre en compte les syllabes qui ont un temps extrêmement court
    i = 0
    for syl in (line.syls):

        if (i % 2) != 0:
            h = h * -1

        else:
            if(h>0):
                h = h * -1

        if syl.duration > 30:
            FU = FrameUtility(line.start_time + syl.start_time, line.start_time + syl.end_time)

            distanceEnterNextSyllable = getDistanceBetweenNextSyllable(line, syl.i)

            if(syl.i == len(line.syls) - 1):
                writeLine(l, FU, syl.center, syl.middle, distanceEnterNextSyllable, "lastSyl")
            else:
                writeLine(l, FU, syl.center, syl.middle, distanceEnterNextSyllable)

            i = i + 1



def writeLine(l, FU, center, middle, distanceEnterNextSyllable, needFad=""):

    a = (0 - h) / (0 - distanceEnterNextSyllable/2 )**2

    #quadratic function
    # f(x) = a * (x-b)^2 + h
    x = Symbol('x')
    y = a * (x - (distanceEnterNextSyllable/2))**2 + h


    # differential equation of y
    yprime = y.diff(x)


    nbrImage = FU.n
    distanceX = distanceEnterNextSyllable/(nbrImage)

    lineDuration = FU.end_time - FU.start_time


    for s, e, i, n in FU:

        positionX = distanceX*(i)
        #quadratic function
        positionY = y.subs(x, positionX)


        tangent = yprime.subs(x, positionX) * (x - positionX) + y.subs(x, positionX)

        # Take random point
        y5 = tangent.subs(x, 5)
        y10 = tangent.subs(x, 10)

        hauteur = y10 - y5

        angle = math.degrees(math.atan(hauteur/5))

        # Looks better like that
        #angle = angle * -1

        l.layer = 1

        l.start_time = s
        l.end_time = e
        l.dur = l.end_time - l.start_time

        l.style = "Edit"
        draw = "m 194 38 l 195 35 192 33 173 31 166 29 177 29 192 29 192 26 167 25 128 24 111 24 90 24 68 23 53 20 41 17 55 14 64 7 64 4 59 5 41 7 31 7 36 5 58 -2 64 -9 52 -7 41 -7 30 -5 8 -4 0 -4 12 -7 23 -11 37 -16 56 -25 64 -31 58 -29 45 -27 28 -24 6 -22 -8 -19 -22 -17 -4 -22 9 -26 21 -31 38 -38 51 -48 61 -56 64 -62 54 -58 44 -53 30 -48 17 -44 -1 -40 -13 -37 -26 -32 -34 -31 -30 -33 -16 -38 2 -47 19 -57 34 -68 45 -78 52 -88 50 -91 45 -88 32 -81 18 -74 3 -65 -12 -57 -28 -50 -49 -41 -58 -40 -47 -46 -29 -57 -12 -70 4 -85 18 -101 24 -112 22 -116 16 -114 4 -104 -6 -95 -21 -83 -33 -74 -54 -61 -70 -52 -79 -46 b -83 -45 -87 -43 -91 -41 -93 -43 -95 -44 -97 -45 -99 -46 -101 -46 -102 -46 l -111 -40 -115 -37 -112 -39 -106 -40 -112 -35 -118 -32 -119 -28 -118 -26 -114 -22 b -113 -20 -112 -19 -111 -17 l -108 -16 -101 -12 -91 -3 -83 5 -77 12 -71 21 -67 28 -59 38 -50 47 -42 55 -26 63 1 69 14 69 26 72 37 71 44 65 52 69 57 72 67 77 81 83 87 83 79 74 68 66 66 54 72 51 81 48 90 50 110 55 129 59 149 63 167 66 169 64 181 66 184 63 173 59 159 56 151 52 161 53 173 54 186 57 191 54 189 51 182 48 174 46 194 46 194 43 185 40 168 38 184 38 194 38"
        draw1 = "m -128 -26 l -129 -28 -128 -32 -122 -35 -116 -40 -122 -39 -127 -36 -135 -30 -142 -24 -136 -23 b -134 -22 -133 -22 -131 -21 -128 -20 -124 -18 -121 -17 -122 -19 -123 -20 -124 -22 l -128 -26"

        # Set alpha if needed
        if(needFad == "leadIn"):
            alpha = 255
            alpha += FU.add(0, lineDuration, -255)
            alpha = Convert.alpha_dec_to_ass(int(alpha))

        elif(needFad == "lastSyl"):
            alpha = 0
            alpha += FU.add(0, lineDuration, 255)
            alpha = Convert.alpha_dec_to_ass(int(alpha))


        if(needFad == "leadIn" or needFad == "lastSyl"):

            l.text = "{\\an7\\pos(%.3f,%.3f)\\frz%.3f\\fry-180\\alpha%s\\p4}%s" % (
                center + positionX,
                middle + positionY,
                angle,
                alpha,
                draw,
            )

            io.write_line(l)

            l.text = "{\\an7\\pos(%.3f,%.3f)\\frz%.3f\\fry-180\shad0\\alpha%s\\c&H4075BE&\\p4}%s" % (
                center + positionX,
                middle + positionY,
                angle,
                alpha,
                draw1,
            )

            io.write_line(l)

        else:
            l.text = "{\\an7\\pos(%.3f,%.3f)\\frz%.3f\\fry-180\\p4}%s" % (
                center + positionX,
                middle + positionY,
                angle,
                draw,
            )

            io.write_line(l)

            l.text = "{\\an7\\pos(%.3f,%.3f)\\frz%.3f\\fry-180\shad0\\c&H4075BE&\\p4}%s" % (
                center + positionX,
                middle + positionY,
                angle,
                draw1,
            )

            io.write_line(l)





def getDistanceBetweenNextSyllable(line, sylIndex):
    distanceEnterNextSyllable = -1

    # For the last syl
    if(sylIndex == len(line.syls) - 1):
        distanceEnterNextSyllable = getDistanceBetweenNextSyllable(line, len(line.syls) - 2)

    # For the leadin
    elif(sylIndex == -1):
        distanceEnterNextSyllable = getDistanceBetweenNextSyllable(line, 0)

    else:
        # On ne veut pas prendre en compte les syllabes qui ont un temps extrêmement court
        if (line.syls)[(sylIndex +1)].duration > 30:
            distanceEnterNextSyllable = (line.syls)[(sylIndex +1)].center - (line.syls)[sylIndex].center
        else:
            distanceEnterNextSyllable = (line.syls)[(sylIndex +2)].center - (line.syls)[sylIndex].center

    return distanceEnterNextSyllable


for line in lines:

    # Generating lines
    if line.style == "Unmei no Hi - Japonais":
        RomanjiSonGoku(line, line.copy())






io.save()
io.open_aegisub()
