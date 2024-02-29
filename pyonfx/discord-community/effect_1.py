# Made by moi15moi
# Inspired by the Team-ARF

from pyonfx import *
from math import *

io = Ass("Input - Effect 1.ass")
meta, styles, lines = io.get_data()

leadin = 300
leadout = 300

originalFsc = 250
differenceFsc = originalFsc - 100

colorBeforeSyl = "&HDBC0D9&"
colorAfterSyl = "&HB2C7DD&"


def calculateDistanceBetweenTwoPoints(x1,y1,x2,y2):
    return sqrt((x2-x1)**2 + (y2-y1)**2)


def getMainEffectText(l, syl):
    text = ""

    for currentSyl in l.syls:

        if currentSyl.prespace:
            text += " "

        if currentSyl.i == syl.i:
            text += "{\\1a&HFF&}" + currentSyl.text
        elif currentSyl.i > syl.i:
            text += "{\\r\\c" + colorBeforeSyl + "}" + currentSyl.text
        else:
            text += "{\\c" + colorAfterSyl + "}" + currentSyl.text

        if currentSyl.postspace:
            text += " "
    
    return text



def romanji(line, l):

    # Lead in
    l.layer = 1
    l.actor = "LeadIn"

    l.start_time = line.start_time - leadin
    l.end_time = line.start_time
    l.dur = l.end_time - l.start_time

    l.text = "{\\an5\\pos(%.3f,%.3f)\\c%s\\fad(%d,0)}%s" % (
        line.center,
        line.middle,
        colorBeforeSyl,
        leadin,
        line.text
    )

    io.write_line(l)

    # Main effect
    for syl in line.syls:

        l.layer = 1
        l.actor = "Main effect Text"

        l.start_time = line.start_time + syl.start_time
        l.end_time = line.start_time + syl.end_time
        l.dur = l.end_time - l.start_time

        l.text = getMainEffectText(l.copy(), syl)

        io.write_line(l)

        if(syl.text):

            pixelArray = Convert.text_to_pixels(syl)
            rayon = 2
            draw = Shape.ellipse(rayon,rayon)

            for i in range(0,len(pixelArray)-1, rayon):

                x, y = syl.left + pixelArray[i].x, syl.top + pixelArray[i].y

                distanceX = x - syl.center 
                distanceY = y - syl.middle
            
                fscx = (differenceFsc / calculateDistanceBetweenTwoPoints(syl.left,syl.top, syl.center,syl.middle)) * calculateDistanceBetweenTwoPoints(x,y, syl.center,syl.middle)
                fscy = (differenceFsc / calculateDistanceBetweenTwoPoints(syl.left,syl.top, syl.center,syl.middle)) * calculateDistanceBetweenTwoPoints(x,y, syl.center,syl.middle)

                # Take the smallest value
                if(fscx <= fscy):
                    fsc = fscx
                else:
                    fsc = fscy

                fsc = originalFsc - fsc

                distanceX = distanceX * fsc/100
                distanceY = distanceY * fsc/100


                l.layer = 5

                l.actor = "Main effect 1/2"

                l.start_time = line.start_time + syl.start_time
                l.end_time = line.start_time + syl.start_time + syl.duration / 2
                l.dur = l.end_time - l.start_time

                l.text = "{\\an5\\move(%d,%d,%d,%d)\\bord0\\shad0\\c%s\\alpha%s\\t(\\c%s)\\t(0.5,\\fscx%.3f\\fscy%.3f)\\p1}%s" % (
                    x, 
                    y, 
                    x + distanceX, 
                    y + distanceY,
                    colorBeforeSyl,
                    Convert.alpha_dec_to_ass(pixelArray[i].alpha),
                    Utils.interpolate(0.5, colorBeforeSyl, colorAfterSyl),
                    fsc, 
                    fsc,
                    draw
                    )
                io.write_line(l)


                l.actor = "Main effect 2/2"

                l.start_time = line.start_time + syl.start_time + syl.duration / 2
                l.end_time = line.start_time + syl.end_time
                l.dur = l.end_time - l.start_time

                l.text = "{\\an5\\move(%d,%d,%d,%d)\\bord0\\shad0\\c%s\\alpha%s\\t(\\c%s)\\fscx%.3f\\fscy%.3f\\t(0.5,\\fscx100\\fscy100)\\p1}%s" % (
                    x + distanceX, 
                    y + distanceY,
                    x, 
                    y,  
                    Utils.interpolate(0.5, colorBeforeSyl, colorAfterSyl),
                    Convert.alpha_dec_to_ass(pixelArray[i].alpha),
                    colorAfterSyl,                    
                    fsc, 
                    fsc,
                    draw
                    )
                io.write_line(l)

    
    # Lead out
    l.layer = 1
    l.actor = "LeadOut"

    l.start_time = line.end_time
    l.end_time = line.end_time + leadout
    l.dur = l.end_time - l.start_time

    l.text = "{\\an5\\pos(%.3f,%.3f)\\c%s\\fad(0,%d)}%s" % (
        line.center,
        line.middle,
        colorAfterSyl,
        leadout,
        line.text
    )

    io.write_line(l)

for line in lines:

    # Generating lines
    if line.style == "Ending - Japonais":
        romanji(line, line.copy())


io.save()
io.open_aegisub()