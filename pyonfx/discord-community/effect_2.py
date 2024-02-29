# Made by moi15moi
# Inspired by the Team-ARF

from pyonfx import *

io = Ass("Input - Effect 2.ass")
meta, styles, lines = io.get_data()

# before syl
colorBeforeSyl = "H30B2F2"
colorBordBeforeSyl = "H000000"

# after syl
colorAfterSyl = "HF17D3A"
colorBordAfterSyl = "HFFFFFF"

def getText(line, iStart, iEnd):
    text = ""

    for i in range(iStart, iEnd):
        if line.syls[i].prespace:
            text += " "

        text += line.syls[i].text

        if line.syls[i].postspace:
            text += " "

    return text
    

def romanji(line, l):


    # Main effect
    for syl in line.syls:

        l.start_time = line.start_time + syl.start_time
        l.end_time = line.start_time + syl.end_time
        l.dur = l.end_time - l.start_time

        # Set text
        l.text = ""

        if syl.prespace:
            l.text += " "

        l.text += (
            "{\\an4\\pos(%.3f,%.3f)\\c&%s&\\3c&%s&"
            "\\t(0,%d,\\fscx150\\fscy150\\c&HFFFFFF&\\3c&%s&\\fsp4)"
            "\\t(%d,%d,\\fscx110\\fscy110\\c&%s&\\fsp0)}%s" % (
                syl.left,
                syl.middle,
                colorBeforeSyl,
                colorBordBeforeSyl,
                syl.duration/2,
                colorBordAfterSyl,
                syl.duration/2,
                syl.duration,
                colorAfterSyl,
                syl.text
            )
        )

        if syl.postspace:
            l.text += " "

        # Syllables after the syllable that is sing
        l.text += "{\\r\\c&%s&}%s" % (
            colorBeforeSyl,
            getText(l, syl.i+1, len(line.syls))
        )

        io.write_line(l)



        # Lead out
        if(len(line.syls)-1 != syl.i):
            l.start_time = line.start_time + syl.end_time
            l.end_time = line.start_time + line.syls[syl.i+1].end_time
            l.dur = l.end_time - l.start_time

            l.text = "{\\an4\\pos(%.3f,%.3f)\\c&%s&\\3c&%s&}%s" % (
                line.syls[0].left,
                line.syls[0].middle,
                colorAfterSyl,
                colorBordAfterSyl,
                getText(l, 0, syl.i+1)
            )
            io.write_line(l)



for line in lines:

    # Generating lines
    if line.style == "Ending - Japonais":

        romanji(line, line.copy())



io.save()
io.open_aegisub()