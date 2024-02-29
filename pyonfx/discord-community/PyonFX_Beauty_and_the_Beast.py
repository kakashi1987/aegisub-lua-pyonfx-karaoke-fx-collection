from pyonfx import *
import random, os, math
dir_path = os.path.dirname(os.path.realpath(__file__))
name = "Beauty and the Beast"
io = Ass(name + ".ass", name + " - Gen.ass")
meta, styles, lines = io.get_data()

def pairs(o):
    if isinstance(o,dict):
        return o.items()
    else:
        return enumerate(o)

star_color = "&H2ADEFF&"

random.seed(11)
cnt = 0

def credit(line, l):
    l.start_time = 0
    l.end_time = 1e9
    l.text = "{\\an7\\bord0\\1a%s\\1c%s\\fscy%d\\fscx%d}%s" % (
        Convert.alpha_dec_to_ass(150),
        "&HFFFFFF&",
        77, 77,
        "KhD7ng"
    )
    io.write_line(l)

def sub(line, l):
    l.start_time = line.start_time
    l.end_time = line.end_time
    l.text = "{\\1c%s\\3c%s}%s" % (
        "&HFFFFFF&",
        "&H4C2C1B&",
        line.text
    )
    io.write_line(l)

color3 = "&HFFFFFF&"
color1 = "&H822784&"

def fx(line, l):
    flag = 0
    def autoTags(duration: int, interval: int, data1: str, data2: str) -> str:
        result = ""
        count = math.ceil(duration/interval)

        for i in range(count):
            if i%2 == 0:
                data = data1
            else:
                data = data2


            result += ("\\t(%d,%d,%s)" % (
                        i*interval,
                        (i+1)*interval,
                        data
                        )
            )

        return result

    l.layer = 3
    # Leadin
    for syl in Utils.all_non_empty(line.syls):
        l.start_time = line.start_time 
        l.end_time = line.start_time + syl.start_time
        dur = syl.duration

        l.text = "{\\pos(%d,%d)\\an5\\fad(200,0)\\blur0.6\\1c%s\\3c%s}%s" % (
            syl.center, syl.middle,
            color1, color3,
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
            color1, color3,
            0, dur / 3, color3, color1,
            syl.text
        )
        io.write_line(l)

    # Create an array contains star position
    pos_x, pos_y = [], []
    for syl in line.syls:
        pos_x.append(syl.center)
        pos_y.append(random.choice([
            line.top - random.uniform(0, 10),
            line.bottom + random.uniform(0, 10)
        ]))

    # Drawing line
    l.layer = 1
    def pos_calculating(x1, y1, x2, y2, cur_x):
        y = y1 + (y2-y1) / (x2-x1) * (cur_x - x1)
        return y

    for syl in line.syls:
        
        if syl.i == len(line.syls) - 1:
            continue

        x_1, x_2 = int(pos_x[syl.i]), int(pos_x[syl.i+1])
        modulo = 3

        # Iterate through every position
        for pos in range(x_1, x_2):
            for i in range(3):

                x, y = pos, pos_calculating(pos_x[syl.i], pos_y[syl.i], pos_x[syl.i+1], pos_y[syl.i+1], pos)
                pp = 17

                pos_dur = Utils.interpolate((pos - x_1) / (x_2 - x_1), 0, syl.duration)
                l.start_time = line.start_time + syl.start_time + pos_dur
                l.end_time = line.end_time

                if i == 0:
                    position = "\\pos(%d,%d)" % (
                        x, y
                    )
                else:
                    position = "\\move(%.1f,%.1f,%.1f,%.1f)" % (
                        x, y, x + random.uniform(-pp, pp), y + random.uniform(-pp, pp)
                    )
                    l.end_time = l.start_time + random.uniform(500, 700)
                
                l.text = "{%s\\fad(200,200)\\an5\\p1\\3c%s\\1c%s\\bord0.5\\blur2}%s" % (
                    position, 
                    star_color, star_color,
                    Shape.ellipse(1, 1)
                )
                io.write_line(l)

        index = random.randint(0, 2)
        if syl.i <= len(line.syls) - 3 and flag == 0:
            flag = 1
            x_1, x_2 = int(pos_x[index]), int(pos_x[index+2])

            # Iterate through every position
            for pos in range(x_1, x_2):
                for i in range(3):

                    x, y = pos, pos_calculating(pos_x[index], pos_y[index], pos_x[index+2], pos_y[index+2], pos)
                    pp = 17

                    pos_dur = Utils.interpolate((pos - x_1) / (x_2 - x_1), 0, line.syls[index].duration + line.syls[index+1].duration)
                    l.start_time = line.start_time + line.syls[index].start_time + pos_dur
                    l.end_time = line.end_time

                    if i == 0:
                        position = "\\pos(%d,%d)" % (
                            x, y
                        )
                    else:
                        position = "\\move(%.1f,%.1f,%.1f,%.1f)" % (
                            x, y, x + random.uniform(-pp, pp), y + random.uniform(-pp, pp)
                        )
                        l.end_time = l.start_time + random.uniform(500, 700)
                    
                    l.text = "{%s\\fad(200,200)\\an5\\p1\\3c%s\\1c%s\\bord0.5\\blur2}%s" % (
                        position, 
                        star_color, star_color,
                        Shape.ellipse(1, 1)
                    )
                    io.write_line(l)

    # Star
    l.layer = 2 
    star = Shape.star(5, 7, 12)

    for syl in line.syls:
        l.start_time = line.start_time
        l.end_time = line.end_time

        l.text = "{\\an5\\p1\\pos(%d,%d)\\fad(200,200)\\bord1\\blur5\\1c%s\\3c%s}%s" % (
            pos_x[syl.i], pos_y[syl.i],
            star_color, star_color,
            star
        )
        io.write_line(l)
    
    # Glowing dot
    l.layer = 1
    star = Shape.star(4, 12, 3)

    for syl in line.syls:
        l.start_time = line.start_time
        l.end_time = line.end_time
        dur = l.end_time - l.start_time

        l.text = "{\\an5\\p1\\pos(%d,%d)\\fad(200,200)\\bord0.5\\blur3\\1c%s\\3c%s%s}%s" % (
            pos_x[syl.i], pos_y[syl.i],
            star_color, star_color,
            autoTags(dur, 150, "\\fscx100\\fscy100", "\\fscx150\\fscy150"),
            star
        )
        io.write_line(l)

for li, line in pairs(lines):

    li = line.copy()

    if cnt == 0:
        credit(line, li)

    if line.effect == "fx":
        fx(line, li)
    else:
        sub(line, li)
    
    cnt += 1

    print("{}/{} - {}%".format(cnt, len(lines), cnt/len(lines)*10000//1/100))

io.save()
io.open_mpv(os.path.join(dir_path, name + " - Gen.mkv"), "00:30")