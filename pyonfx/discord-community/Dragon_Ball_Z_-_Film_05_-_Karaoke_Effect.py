# Made by moi15moi
# Inspired by the Team-ARF

from pyonfx import *

io = Ass("Dragon Ball Z - Film 5 - Karaoke.ass")
meta, styles, lines = io.get_data()

help_start_before = 750


def RomanjiPrincipal(line, l):
    
    # Leadin Effect
    l.layer = 0

    l.start_time = line.start_time - 250
    l.end_time = line.start_time
    l.dur = l.end_time - l.start_time

    l.text = "{\\an2\\pos(%.3f,%.3f)\\frx90\\t(0,%d,\\frx5)\\1c&HFCF6F2&}%s" % (
        l.center,
        l.bottom,
        l.dur,
        l.text,
    )

    io.write_line(l)
    
    
    # Main Effect
    l.layer = 1

    l.start_time = line.start_time
    l.end_time = line.end_time
    l.dur = l.end_time - l.start_time
        

    # We don't want to repeat this, so I write it outside the loop
    l.text = "{\\an2\\pos(%.3f,%.3f)}" % (
        l.center,
        l.bottom,
    )
    
    containsSylOver2500Duration = False
    
    for syl in Utils.all_non_empty(line.syls):
    
        # This solution is not good, because it will only work if the syl is the last syl of the line. Also, it repeat the line 3 times for no good reason. If you have a solution, feel free to contact me
        if syl.duration > 2500:
            containsSylOver2500Duration = True
            
            l_copy = l.copy()
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,\\1c&H525359&\\frx380)}%s" % (
            syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l_copy)
            
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.75,\\1c&H525359&\\frx380)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l_copy)
            
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,1.25,\\1c&H525359&\\frx380)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )   
            io.write_line(l_copy)
            
        else:
            l.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.5,\\1c&H525359&\\frx20)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )            

    if not containsSylOver2500Duration:
        io.write_line(l)      

    
    
    # Leadout Effect
    l.layer = 0

    l.start_time = line.end_time
    l.end_time = line.end_time + 100
    l.dur = l.end_time - l.start_time

    l.text = "{\\an2\\pos(%.3f,%.3f)\\frx30\\t(0,%d,\\frx90)\\1c&H525359&}%s" % (
        line.center,
        line.bottom,
        l.dur,
        line.text,
    )

    io.write_line(l)

# The only difference with RomanjiPrincipal is the leadout. It now do a fad
def RomanjiPrincipalLast(line, l):
    
    # Leadin Effect
    l.layer = 0

    l.start_time = line.start_time - 250
    l.end_time = line.start_time
    l.dur = l.end_time - l.start_time

    l.text = "{\\an2\\pos(%.3f,%.3f)\\frx90\\t(0,%d,\\frx5)\\1c&HFCF6F2&}%s" % (
        l.center,
        l.bottom,
        l.dur,
        l.text,
    )

    io.write_line(l)
    
    
    # Main Effect
    l.layer = 1

    l.start_time = line.start_time
    l.end_time = line.end_time
    l.dur = l.end_time - l.start_time
        

    # We don't want to repeat this, so I write it outside the loop
    l.text = "{\\an2\\pos(%.3f,%.3f)\\fad(0,900)}" % (
        l.center,
        l.bottom,
    )
    
    containsSylOver2500Duration = False
    
    for syl in Utils.all_non_empty(line.syls):
    
        # This solution is not good, because it will only work if the syl is the last syl of the line. Also, it repeat the line 3 times for no good reason. If you have a solution, feel free to contact me
        if syl.duration > 2500:
            containsSylOver2500Duration = True
            
            l_copy = l.copy()
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,\\1c&H525359&\\frx380)}%s" % (
            syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l_copy)
            
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.75,\\1c&H525359&\\frx380)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l_copy)
            
            l_copy.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,1.25,\\1c&H525359&\\frx380)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )   
            io.write_line(l_copy)
            
        else:
            l.text = l.text + ("{\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.5,\\1c&H525359&\\frx20)}%s" % (
                    syl.start_time,
                    syl.end_time,
                    syl.text + " " if syl.postspace else syl.text
                )
            )            

    if not containsSylOver2500Duration:
        io.write_line(l)




def RomanjiHelp(line, l):
    
    # Leadin Effect
    numberOfChars = len(Utils.all_non_empty(line.chars))
    durationBetweenEachChar = help_start_before / numberOfChars    
    i = numberOfChars
    
    for char in Utils.all_non_empty(line.chars):

        l.layer = 1

        l.start_time = line.start_time - (durationBetweenEachChar * i)
        l.end_time = line.start_time
        l.dur = l.end_time - l.start_time
        
        i = i-1

        l.text = "{\\an5\\pos(%.3f,%.3f)\\1c&HFFFEFF&\\frx80\\fry30\\t(0,%.3f,\\frx0\\fry0}%s" % (
            char.center,
            char.middle,
            durationBetweenEachChar + 80,
            char.text,
        )

        io.write_line(l)
        
        


    # Main Effect
    for syl in Utils.all_non_empty(line.syls):

        l.layer = 1

        l.start_time = line.start_time
        l.end_time = line.start_time + syl.end_time
        l.dur = l.end_time - l.start_time

        jump = 10
        for i in range(1, 5):
            l.text = (
                "{\\an5\\1c&HFFFEFF&\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)"
                "\\t(%d,%d,0.5,\\fscx125\\fscy125\\1a&HFF&)}%s"
                % (
                    syl.center,
                    syl.middle,
                    syl.center,
                    syl.middle - (jump * i),
                    syl.start_time,
                    syl.end_time,
                    syl.start_time,
                    syl.end_time,
                    syl.text,
                )
            )

            io.write_line(l)
 


def RomanjiLongHelp(line, l):
    # LeadIn Effect
    l.layer = 0

    l.start_time = line.start_time - help_start_before
    l.end_time = line.end_time
    l.dur = l.end_time - l.start_time

    l.text = "{\\an5\\pos(%.3f,%.3f)\\1c&H000000&\\3c&HC1A38C&\\bord2}%s" % (
        l.center,
        l.middle,
        l.text,
    )
    io.write_line(l)

           
    # Leadout Effect
    l.layer = 0
    
    l.start_time = line.end_time
    l.end_time = line.end_time + 350
    l.dur = l.end_time - l.start_time
    
    
    l.text = "{\\an5\\pos(%.3f,%.3f)\\1c&H000000&\\3c&HC1A38C&\\bord2\\clip(%.3f, %.3f, %.3f, %.3f)\\t(0,%d,\\frx90)}%s" % (
        l.center,
        l.middle,
        l.left - 30,
        l.middle,
        l.right + 30,
        l.bottom,
        l.dur,
        line.text,
    )
    
    io.write_line(l)    

    l.text = "{\\an5\\pos(%.3f,%.3f)\\1c&H000000&\\3c&HC1A38C&\\bord2\\clip(%.3f, %.3f, %.3f, %.3f)\\t(0,%d,\\frx-90)}%s" % (
       l.center,
       l.middle,
       l.left - 30,
       l.top,
       l.right + 30,
       l.middle,
       l.dur,
       line.text,
    )
    
    io.write_line(l)
       
 



def RomanjiPrincipalPower(line, l):
    
    # Leadin Effect
    l.layer = 0

    l.start_time = line.start_time - 250
    l.end_time = line.start_time + line.syls[0].duration
    l.dur = l.end_time - l.start_time

    l.text = "{\\an2\\pos(%.3f,%.3f)\\frx90\\t(0,250,\\frx0)\\1c&HFCF6F2&}%s" % (
        l.center,
        l.bottom,
        l.text,
    )

    io.write_line(l)
    
    
    # Main Effect
    l.layer = 1

    l.start_time = line.start_time + line.syls[0].duration
    l.end_time = line.end_time
    l.dur = l.end_time - l.start_time
    
    i = 0
    for syl in Utils.all_non_empty(line.syls):

        if i == 0:
            l.text = ("{\\an6\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.right,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l)
            
            l.text = ("{\\an6\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.5,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.right,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l)
            
            l.text = ("{\\an6\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,1,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.right,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )  
            io.write_line(l)
        else:
            l.text = ("{\\an4\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.left,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l)
            
            l.text = ("{\\an4\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,0.5,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.left,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )
            io.write_line(l)

            l.text = ("{\\an4\\pos(%.3f,%.3f)\\1c&HFCF6F2&\\frx5\\t(%d,%d,1,\\bord3\\3c&HB9D9ED&\\fscx300\\fscy300)}%s" % (
                    syl.left,
                    syl.middle,
                    syl.start_time - line.syls[0].duration,
                    syl.end_time - line.syls[0].duration,
                    syl.text + " " if syl.postspace else syl.text
                )
            )  
            io.write_line(l)

        i = i+1


def sub(line, l):
    # Translation Effect
    l.start_time = line.start_time - 250
    l.end_time = line.end_time + 100
    l.dur = l.end_time - l.start_time

    l.text = "{\\an2\\fad(%d,%d)\\pos(%.3f,%.3f)}%s" % (
        250, 
        100, 
        l.center,
        l.bottom,
        line.text
    )

    io.write_line(l)


for line in lines:
    
    # Generating lines
    if line.style == "Ending - Japonais" or line.style == "Ending - Japonais - Bas":
        RomanjiPrincipal(line, line.copy())    
    elif line.style == "Ending - Japonais - Last":
        RomanjiPrincipalLast(line, line.copy())    
    
    
    elif line.style == "Ending - Japonais - Help" or line.style == "Ending - Japonais - Help - Bas":
        RomanjiHelp(line, line.copy())
    
    
    elif line.style == "Ending - Japonais - Long Help" or line.style == "Ending - Japonais - Long Help - Bas":
        RomanjiLongHelp(line, line.copy())  
    
    
    elif line.style == "Ending - Japonais - Power":
        RomanjiPrincipalPower(line, line.copy())        
    
    
    elif line.style == "Ending - Traduction":
        sub(line, line.copy())
        
        
io.save()
io.open_aegisub()
