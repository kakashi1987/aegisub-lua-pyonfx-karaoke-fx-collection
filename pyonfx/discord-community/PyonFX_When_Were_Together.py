from pyonfx import *
import random, os, math
dir_path = os.path.dirname(os.path.realpath(__file__))
name = "When We're Together"
io = Ass(name + ".ass", name + " - Gen.ass")
meta, styles, lines = io.get_data()

def pairs(o):
    if isinstance(o,dict):
        return o.items()
    else:
        return enumerate(o)

random.seed(7)
white = "&HFFFFFF&"
blue = "&H740000&"
count = 0
for li, line in pairs(lines):
    count += 1
    l = line.copy()
    
    if line.effect == "fx":
        # Leadin
        for syl in Utils.all_non_empty(line.syls):
            l.start_time = line.start_time
            l.end_time = line.start_time + syl.start_time

            l.text = "{\\pos(%d,%d)\\an5\\fad(200,0)\\4c%s\\shad1.5\\bord1.2\\blur0.6\\1c%s\\3c%s}%s" % (
                syl.center, syl.middle,
                white,
                white, white,
                syl.text
            )
            io.write_line(l)      

        for syl in Utils.all_non_empty(line.syls):
            # Main
            l.layer = 0
            l.start_time = line.start_time + syl.start_time
            l.end_time = line.end_time

            fad = "\\fad(0,200)"
            if syl.i == 0:
                fad = "\\fad(200,200)"

            l.text = "{\\an5\\pos(%d,%d)\\1c%s\\3c%s\\4c%s\\shad1.5\\bord1.2\\blur0.6%s}%s" % (
                syl.center, syl.middle,
                white,
                white,
                white,
                fad,
                syl.text
            )
            io.write_line(l)

            l.text = "{\\an5\\pos(%d,%d)\\1c%s\\bord0\\blur0.6%s}%s" % (
                syl.center, syl.middle,
                blue, 
                fad,
                syl.text
            )
            io.write_line(l)

        l.layer = 1    
        l.style = "p"

        for li, syl in pairs(line.syls):

            pix_num = Convert.text_to_pixels(syl)
            x = random.uniform(2, 3)
            p_sh = Shape.ellipse(x, x)

            for pix in range(len(pix_num)):

                ran_pix = random.randint(-pix, pix)

                xr =  math.floor(syl.left) + pix_num[ran_pix].x  
                yr =  math.floor(syl.top) + pix_num[ran_pix].y
                pnum = pix / len(pix_num)
                lops_dur = Utils.interpolate(pnum, 0, syl.duration, 1.5)
                
                x = random.randint(1, 10)
                if x in [1, 2, 3]:
                      
                    # Static pixel
                    l.start_time = line.start_time + syl.start_time
                    l.end_time = line.start_time + syl.start_time + lops_dur

                    l.layer = 1
                    l.text = "{\\p2\\an5\\pos(%d,%d)\\1c%s\\3c%s\\bord1\\blur1\\shad0}%s" % (
                        xr, yr, 
                        white,
                        white,
                        p_sh
                    )
                    io.write_line(l)
                
                x = random.randint(1, 25)
                if x in [1, 7]:

                    frand = random.randint(80, 100)
                    fad = "\\fad(0,0)"

                    # Falling pixel
                    l.start_time = line.start_time + syl.start_time + lops_dur
                    l.end_time = line.start_time + syl.start_time + lops_dur + random.uniform(500, 700)

                    if syl.i == len(line.syls) - 1:
                        l.end_time = line.end_time
                        fad = "\\fad(0,200)"
                    elif syl.i == 1:
                        fad = "\\fad(200,0)"

                    l.dur = l.end_time - l.start_time
                    l.layer = 2
                    l.text = "{\\p2\\an5\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)\\1c%s\\3c%s\\bord1\\blur1\\shad0%s}%s" % (
                        xr, yr, xr + random.uniform(-77, 77), yr + random.uniform(150, 170),
                        0,
                        random.uniform(1700, 2000),
                        white,
                        white,
                        fad,
                        p_sh
                    )
                    io.write_line(l)
    else:
        l.start_time = line.start_time
        l.end_time = line.end_time
        l.text = "{\\1c%s\\3c%s}%s" % (
            "&HFFFFFF&",
            "&H4C2C1B&",
            line.text
        )
        io.write_line(l)
 
    print("{}/{} - {}%".format(count, len(lines), count/len(lines)*10000//1/100))

io.save()
io.open_mpv(os.path.join(dir_path, name + " - Gen.mkv"), "01:40")