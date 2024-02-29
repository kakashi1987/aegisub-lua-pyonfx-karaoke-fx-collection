
# Made by moi15moi and SwooZ

from pyonfx import *
import random
io = Ass("Ending_1 (1).ass")
meta, styles, lines = io.get_data()


def romaji(line, l):
    
    # Leadin Effect
    color = ["&HF0FFFF&","&HA6F0F3&","&HEFDA7F&","&HB8EFA1&","&HBF8C3F&","&H38BFC8&","&H2C1CB5&","&HB3F480&","&H905E4B&","&H3CE1F6&","&H565EF7&","&H8A5FE8&","&H814139&","&HE1EAED&","&H130F47&","&H544D14&"]
    numberOfSyls = len(Utils.all_non_empty(line.syls))
    
    if line.leadin < 400:
        leadin = 400
    elif line.leadin < 650:
        leadin = line.leadin
    else:
        leadin = 650
    durationBetweenEachSyl = leadin / numberOfSyls    
    
    i = numberOfSyls
    j = 0
    
    for syl in Utils.all_non_empty(line.syls):
        l.layer = 0
        l.effect = "Leadin"

        l.start_time = line.start_time - (durationBetweenEachSyl * i)
        if (line.start_time + (durationBetweenEachSyl * j)) < line.start_time + syl.start_time:
            l.end_time = line.start_time + (durationBetweenEachSyl * j)
        else:
            l.end_time = line.start_time + syl.start_time
        l.dur = l.end_time - l.start_time
        
        
        color0= color[random.randint(0, len(color)) - 1]
        color1= color[random.randint(0, len(color)) - 1]
        color2= color[random.randint(0, len(color)) - 1]
        
        
        l.text = (
            "{\\an5\\pos(%.3f,%.3f)"
            "\\fad(250,0)\\frz90\\frx90\\t(\\frz0\\frx0)\\blur1"
            "\\org(%.3f, %.3f)"
            "\\1c%s\\3c%s\\4c%s}%s" % (
                syl.center,
                syl.middle,
                syl.center,
                syl.middle - 75,
                color0,
                color1,
                color2,
                syl.text,
            )
        )

        io.write_line(l)
        
        
        l.layer = 0        
        l.effect = "Transition" 
        
        # La dernière syllabe n'a pas besoins de cette partie de code
        if (line.start_time + (durationBetweenEachSyl * j)) < line.start_time + syl.start_time:
            
            l.start_time = line.start_time + (durationBetweenEachSyl * j)
            l.end_time = line.start_time + syl.start_time
            l.dur = l.end_time - l.start_time

            l.text = (
                "{\\an5\\pos(%.3f,%.3f)\\1c%s\\3c%s\\4c%s\\blur1}%s" % (
                    syl.center,
                    syl.middle,
                    color0,
                    color1,
                    color2,                    
                    syl.text,
                )
            )
            io.write_line(l)        

        i = i-1
        j = j + 1
        
        

        # Main Effect
        l.layer = 1
        l.effect = "Main Effect"

        l.start_time = line.start_time + syl.start_time
        l.end_time = line.start_time + syl.end_time + 1000
        l.dur = l.end_time - l.start_time
        
        color0= color[random.randint(0, len(color)) - 1]
        color1= color[random.randint(0, len(color)) - 1]
        
        l.text = (
            "{\\an5\\pos(%.3f,%.3f)"
            "\\bord3\\blur1\\t(0,25,\\fscx150\\fscy150\\3c&H3D4548&\\1c&HE2E2ED&)"
            "\\t(25,%.3f,\\fscx100\\fscy100\\3c%s!)"
            "\\1c%s"
            "\\t(500,1000,\\bord1\\blur5)\\fad(0,1000)}%s"
            % (
                syl.center,
                syl.middle,         
                syl.duration,
                color0,
                color1,
                syl.text,
            )
        )

        io.write_line(l)
    
def sub(line, l):
    
    # Leadin Effect
    numberOfChars = len(Utils.all_non_empty(line.chars))
    if line.leadin < 400:
        leadin = 400
    elif line.leadin < 650:
        leadin = line.leadin
    else:
        leadin = 650
    durationBetweenEachChar = leadin / numberOfChars    
    
    i = numberOfChars
    j = 0
    
    for char in Utils.all_non_empty(line.chars):
        l.effect = "Translation"

        l.start_time = line.start_time - (durationBetweenEachChar * i)
        l.end_time = line.end_time + 350
        l.dur = l.end_time - l.start_time
       
        leadinDuration = (durationBetweenEachChar * j) + (durationBetweenEachChar * i)
        
        l.text = (
            "{\\an5\\pos(%.3f,%.3f)\\blur20\\bord0"
            "\\t(0,%d,\\bord1.250)"
            "\\t(0,%d,\\blur0)"
            "\\fad(0,300)}%s" % (
                char.center,
                char.middle,
                leadinDuration * 0.50,
                leadinDuration * 0.50,
                char.text,
            )
        )

        io.write_line(l)
        

        
        i = i-1        
        j = j + 1
  



for line in lines:
    # Generating lines
    if line.style == "ED":
        romaji(line, line.copy())
    elif line.style == "ED-trad":
        sub(line, line.copy())


io.save()
io.open_aegisub()
