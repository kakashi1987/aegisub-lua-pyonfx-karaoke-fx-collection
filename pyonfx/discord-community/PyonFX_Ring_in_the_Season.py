from pyonfx import *
import random, os, math
dir_path = os.path.dirname(os.path.realpath(__file__))
name = "Ring in the Season"
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
cnt = 0

def sub(line, l):
    l.start_time = line.start_time
    l.end_time = line.end_time
    l.text = "{\\1c%s\\3c%s}%s" % (
        "&HFFFFFF&",
        "&H4C2C1B&",
        line.text
    )
    io.write_line(l)

def fx(line, l):

    # Leadin
    for syl in Utils.all_non_empty(line.syls):
        l.start_time = line.start_time 
        l.end_time = line.start_time + syl.start_time
        dur = syl.duration

        l.text = "{\\pos(%d,%d)\\an5\\fad(200,0)\\blur0.6\\1c%s\\3c%s}%s" % (
            syl.center, syl.middle,
            line.styleref.color1, line.styleref.color3,
            syl.text
        )
        io.write_line(l)

    # Main + Leadout
    for syl in Utils.all_non_empty(line.syls):
        if syl.i == 0:
            fad = "\\fad(200, 200)"
        else:
            fad = "\\fad(0, 200)"
        l.start_time = line.start_time + syl.start_time
        l.end_time = line.end_time
        dur = syl.duration

        l.text = "{\\pos(%d,%d)\\an5%s\\blur0.6\\1c%s\\3c%s\\t(%d,%d,\\1c%s\\3c%s)}%s" % (
            syl.center, syl.middle,
            fad,
            line.styleref.color1, line.styleref.color3,
            0, dur / 3, line.styleref.color3, line.styleref.color1,
            syl.text
        )
        io.write_line(l)

    for syl in Utils.all_non_empty(line.syls):

        fsc = 7
        l.layer = 1

        c1 = "&HF1FF9D&"
        c3 = "&HFFFFFF&"
    
        # Animating star shape that jumps over the syllables
        # Jump-in to the first syl
        jump_height = 27
        delay = 500
        if syl.i == 0:
            FU = FrameUtility(line.start_time - 300, line.start_time)
            for s, e, i, n in FU:
                for _ in range(10):
                    l.start_time = s
                    l.end_time = s + random.uniform(400, 700)
                    frame_pct = i / n

                    size = random.randint(5, 50)

                    x = syl.center - syl.width * (1 - frame_pct)
                    y = syl.top - math.sin(frame_pct * math.pi) * jump_height

                    alpha = 255
                    alpha += FU.add(0, syl.duration, -255)
                    alpha = Convert.alpha_dec_to_ass(int(alpha))

                    l.text = "{\\fad(0,200)\\an5\\alpha%s\\move(%.3f,%.3f,%.3f,%.3f)\\bord1\\blur2\\1c%s\\3c%s\\p1\\fscx%d\\fscy%d}%s" % (
                        alpha,
                        x, y, x + 70 - random.uniform(70, 100), y + random.uniform(-20, 20),
                        c1, c3,
                        fsc, fsc,
                        Shape.ellipse(size, size)
                    )
                    io.write_line(l)

        # Jump to the next syl or to the end of line
        jump_width = (
            line.syls[syl.i + 1].center - syl.center
            if syl.i != len(line.syls) - 1
            else syl.width * 1.75
        )
        delay = 300
        FU = FrameUtility(
            line.start_time + syl.start_time, line.start_time + syl.end_time
        )
        for s, e, i, n in FU:
            for _ in range(10):
                l.start_time = s
                l.end_time = s + random.uniform(400, 700)
                frame_pct = i / n

                size = random.randint(5, 50)

                x = syl.center + frame_pct * jump_width
                y = syl.top - math.sin(frame_pct * math.pi) * jump_height

                x, y = x + random.uniform(-10, 10), y + random.uniform(-5, 5),

                alpha = 0
                # Last jump should fade-out
                if syl.i == len(line.syls) - 1:
                    alpha += FU.add(0, syl.duration, 255)
                alpha = Convert.alpha_dec_to_ass(int(alpha))

                l.text = "{\\fad(0,200)\\an5\\alpha%s\\move(%.3f,%.3f,%.3f,%.3f)\\bord1\\blur2\\1c%s\\3c%s\\p1\\fscx%d\\fscy%d}%s" % (
                    alpha,
                    x, y, x + 70 - random.uniform(70, 100), y + random.uniform(-20, 20),
                    c1, c3,
                    fsc, fsc,
                    Shape.ellipse(size, size)
                )
                io.write_line(l)

for li, line in pairs(lines):

    li = line.copy()

    if line.effect == "fx":
        fx(line, li)
    else:
        sub(line, li)
    
    cnt += 1
 
    print("{}/{} - {}%".format(cnt, len(lines), cnt/len(lines)*10000//1/100))

io.save()
io.open_mpv(os.path.join(dir_path, name + " - Gen.mkv"), "01:40")