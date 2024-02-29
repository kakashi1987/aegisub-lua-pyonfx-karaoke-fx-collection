from pyonfx import *
import math
import random
import time

random.seed(time.time())

io = Ass("Kokkoku - OP.ass", "Kokkoku - Effect.ass")
meta, styles, lines = io.get_data()

def make_squares(left, dist, shape_width):
    index = [left]
    new_left = left
    for i in range(dist):
        new_left += shape_width
        index.append(new_left)
    return index

def make_alphas(time, alpha_init, alpha_last, frame_dur = 41.7):
    tags, val = "", 0
    while val < time:
        alphas = alpha_init if random.randint(0, 1) == 0 else alpha_last
        tags += "\\t(%d,%d,\\1a%s\\3a%s\\4a%s)" % (
            val,
            val + 1,
            alphas,
            "&HA0&" if alphas == "&H00&" else alphas,
            alphas
        )
        val += frame_dur
    return tags

def list_oscill(time, list, init = 0, frame_dur = 41.7, tag = "\\alpha"):
    tags, val, i, n = "", init, 0, len(list)
    while val < time:
        tags += "\\t(%d,%d,%s%s)" % (
            val,
            val + 1,
            tag,
            list[i % n]
        )
        val += frame_dur + init
        i += 1
    return tags

def karaoke(line, l):
    l.effect, l.actor = "", ""
    l.start_time = line.start_time
    l.end_time = line.end_time
    l.duration = l.end_time - l.start_time

    def set_colors():
        color = "&HFFFFFF&"
        if l.start_time >= Convert.time("0:00:10.844"):
            color = "&H000000&"
        if l.start_time >= Convert.time("0:00:48.840"):
            color = "&HFFFFFF&"
        if l.start_time >= Convert.time("0:01:09.110"):
            color = "&H7C40EA&"
        if l.start_time >= Convert.time("0:01:12.947"):
            color = "&HFFFFFF&"
        return color

    set_c = set_colors()
    color = "\\c%s" % (set_c)

    if line.style == "romaji":
        if line.actor == "add_shape":
            shapes = [
                "m 0 0 l 50 0 l 50 50 l 0 50 l 0 0 ",
                "m 50 0 l 100 0 l 100 50 l 50 50 l 50 0 ",
                "m 50 50 l 100 50 l 100 100 l 50 100 l 50 50 ",
                "m 0 50 l 50 50 l 50 100 l 0 100 l 0 50 "
            ]
            dist = math.floor(l.width / 100 + 0.5)
            squares = make_squares(l.left, dist, 100)
            change_color = random.randint(2, 6)
            solid_color, j = [], 0

            for i in range(change_color):
                solid_color.append(Convert.color_hsv_to_ass((random.randint(0, 300), 100, 100)))
            colors = list_oscill(l.duration, solid_color, 200, l.duration / change_color, "\\c")

            for posix in squares:
                j += 1
                for i in range(4):
                    alphas = make_alphas(300, "&HFF&", "&H80&")
                    l.text = "{\\an7\\pos(%d,%d)\\bord0\\shad0%s\\c%s%s\\t(300,301,\\alpha%s)\\p1}%s" % (
                        posix - 50,
                        l.middle - l.top,
                        alphas,
                        Convert.color_hsv_to_ass( (random.randint(0, 300), 100, 100) ),
                        colors,
                        Convert.alpha_dec_to_ass(90 if j % 2 == 0 else 180),
                        shapes[i]
                    )
                    io.write_line(l)

        for syl in Utils.all_non_empty(line.syls):
            for i in range(2): # make lead-in and lead-out
                alpha = make_alphas(300, "&HFF&", "&H00&", 41.7)
                preset = "\\bord3\\blur3" if line.actor != "add_shape" else "\\bord0"
                if i == 1:
                    l.start_time = line.start_time
                    l.end_time = line.start_time + syl.start_time
                    l.duration = l.end_time - l.start_time
                    l.text = "{\\an5\\pos(%d,%d)%s%s%s\\3c&HFFFFFF&\\t(300,301,\\1a&H00&\\3a&HA0&)}%s" % (
                        syl.center,
                        syl.middle,
                        preset,
                        color,
                        alpha,
                        syl.text
                    )
                else:
                    l.start_time = line.start_time + syl.end_time
                    l.end_time = line.end_time
                    l.duration = l.end_time - l.start_time
                    l.text = "{\\an5\\pos(%d,%d)%s%s\\3c&HFFFFFF&\\3a&HA0&}%s" % (
                        syl.center,
                        syl.middle,
                        preset,
                        color,
                        syl.text
                    )
                io.write_line(l)
            l.start_time = line.start_time + syl.start_time
            l.end_time = line.start_time + syl.end_time
            l.duration = l.end_time - l.start_time
            l.text = "{\\an5\\pos(%d,%d)\\bord3\\blur3%s\\3c&HFF5200&}%s" % (
                syl.center,
                syl.middle,
                color,
                syl.text
            )
            io.write_line(l)

            # hightlight
            # gap = 20
            # h_val = (l.height + 10) / gap
            # for j in range(gap):
            #     clip = "\\clip(%d,%d,%d,%d)" % (0, l.top + j * h_val, meta.play_res_x, l.top + (j + 1) * h_val)
            #     gradient = Utils.interpolate(j / gap, "&HFFFFFF&", "&H000000&")
            #     l.text = "{\\an5\\pos(%d,%d)\\bord3\\blur3\\c%s\\3c&HFFFFFF&\\3a&HA0&%s}%s" % (
            #         syl.center,
            #         syl.middle,
            #         gradient,
            #         clip,
            #         syl.text
            #     )
            #     io.write_line(l)

            f_by_f, s_loop = math.floor(line.duration / 41.7 + 0.5), 2
            alphas = ["\\1a&HC0&\\3a&HC0&", "\\1a&H80&\\3a&H80&"]
            for j in range(s_loop):
                for i in range(f_by_f):
                    l.start_time = line.start_time + syl.start_time + syl.duration * (i - 1) / f_by_f
                    l.end_time = line.start_time + syl.start_time + syl.duration * i / f_by_f
                    l.duration = l.end_time - l.start_time
                    l.text = "{\\an5\\pos(%d,%d)\\bord3\\blur1\\c%s\\3c&HFF5200&%s}%s" % (
                        syl.center + random.randint(-8, 8),
                        syl.middle + random.randint(-8, 8),
                        Convert.color_hsv_to_ass((random.randint(0, 300), 100, 100)),
                        alphas[j],
                        syl.text
                    )
                    io.write_line(l)
    else:
        for word in Utils.all_non_empty(line.words):
            alpha = make_alphas(300, "&HFF&", "&H00&", 41.7)
            l.start_time = line.start_time
            l.end_time = line.end_time
            l.duration = l.end_time - l.start_time
            l.text = "{\\an5\\pos(%d,%d)\\bord3\\blur3%s%s\\3c&HFFFFFF&\\t(300,301,\\1a&H00&\\3a&HA0&)}%s" % (
                word.center,
                word.middle,
                color,
                alpha,
                word.text
            )
            io.write_line(l)

for line in lines:
    if line.effect == "apply":
        karaoke(line, line.copy())

io.save()
io.open_aegisub()