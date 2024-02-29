# Made by moi15moi

from pyonfx import *

io = Ass("Dragon Ball Z - Film 09 - Karaoke.ass")
meta, styles, lines = io.get_data()


def romaji(line, l):
    for syl in Utils.all_non_empty(line.syls):
        # Leadin Effect
        l.layer = 0

        l.start_time = line.start_time + syl.start_time - 500
        l.end_time = line.start_time + syl.start_time
        l.dur = l.end_time - l.start_time

        l.text = "{\\an5\\move(%.3f,%.3f, %.3f,%.3f)\\fad(%d,0)\\fscx25\\fscy25\\t(0,%d,\\fscx105\\fscy105)\\blur1}%s" % (
            syl.center,
            0,
            syl.center,
            syl.middle,
            l.dur/2,
            l.dur,
            syl.text,
        )

        io.write_line(l)

        # Main Effect
        l.layer = 1

        l.start_time = line.start_time + syl.start_time
        l.end_time = line.end_time
        l.dur = l.end_time - l.start_time

        l.text = (
            "{\\an5\\move(%.3f,%.3f,%.3f,%.3f,0, %d)\\blur1"
            "\\t(0,%d,0.5,\\1c&HFFFFFF&\\3c&HABABAB&\\fscx125\\fscy125)"
            "\\t(%d,%d,0.5,\\1c&HFE893B&\\3c&HABABAB&\\fscx100\\fscy100)"
            "\\t(%d,%d,\\1c&HFE893B&\\3c&H131336&)}%s"
            % (
                syl.center,
                syl.middle,
                syl.center,
                syl.middle - 30,
                (syl.end_time - syl.start_time)/2,
                (syl.end_time - syl.start_time)/2,
                (syl.end_time - syl.start_time)/2,
                (syl.end_time - syl.start_time),
                (syl.end_time - syl.start_time),
                (syl.end_time - syl.start_time),
                syl.text,
            )
        )

        io.write_line(l)

        # Leadout Effect
        l.layer = 0

        l.start_time = line.words[syl.word_i].end_time
        l.end_time = line.end_time + 350
        l.dur = l.end_time - l.start_time

        l.text = "{\\an5\\pos(%.3f,%.3f)\\fad(0,%d)\\1c&HFE893B&\\t(%d,%d,\\fry-90)\\blur1}%s" % (
            line.words[syl.word_i].center,
            line.words[syl.word_i].middle - 30,
            line.leadout / 2,
            line.end_time - l.start_time,
            l.dur,
            line.words[syl.word_i].text,
        )

        io.write_line(l)




def sub(line, l):
    # Translation Effect
    l.start_time = line.start_time - 500
    l.end_time = line.end_time
    l.dur = l.end_time - l.start_time

    l.text = "{\\fad(%d,%d)\\pos(961.333,638)}%s" % (
        500,
        200,
        line.text,
    )

    io.write_line(l)


for line in lines:
    # Generating lines
    if line.style == "Ending - Japonais":
        romaji(line, line.copy())
    elif line.style == "Ending - Traduction":
        sub(line, line.copy())


io.save()
io.open_aegisub()
