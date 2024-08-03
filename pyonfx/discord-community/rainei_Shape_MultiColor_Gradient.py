
from pyonfx import *
import random, os, math
dir_path = os.path.dirname(os.path.realpath(__file__))
name = "[Shape] MultiColor Gradient"
io = Ass(name + ".ass", "[rainei]" + name + ".ass")
meta, styles, lines = io.get_data()

####### REUSABLE FUNCTIONS #######
def autoTags(duration: int, interval: int, data1: str, data2: str) -> str:
    rand = random.randint(0,1)
    result = ""
    count = math.ceil(duration / interval)

    for i in range(count):
        data = data1 if i % 2 == rand else data2
        result += f"\\t({i * interval},{(i + 1) * interval},{data})"

    return result

def alpha(alpha: int) -> str:
    alpha = Convert.alpha_dec_to_ass(alpha)
    return f"\\alpha{alpha}"

def size(x, y) -> str:
    return f"\\fscx{x}\\fscy{y}"

def divideInterval(y1, y2, k):
    """
    Return k points between y1 and y2
    E.g: print(divideInterval(0, 10, 5))  # Output: [0.0, 2.5, 5.0, 7.5, 10.0]
    """

    if k > 2:
        delta_y = (y2 - y1) / (k - 1)
        points = [y1 + i * delta_y for i in range(k)]
        return points
    
    return [y1, y2]

def getBounding(shape, fsc, percentage = 1):

    """percentage parameter corresponds to the \p"""
    box = Shape(shape).bounding()
    box = [math.floor(i * fsc/100 * 1/percentage) for i in box]
    return box

####### SETUP #######
random.seed(7)
cnt = 0
highlight = "&H740000&"
pi = math.pi
fsc = 150
c1 = "&H0084FF&"
x, y = 1920/2, 1080/2
gaim = "m -15 -85 b -57 -85 -99 -51 -99 0 -99 51 -59 86 -13 86 39 86 72 44 72 0 72 -7 71 -15 69 -22 l 60 -14 b 63 -4 62 6 61 16 44 16 39 19 35 28 25 29 20 33 17 40 7 40 -2 42 -6 54 -11 58 -15 62 -16 68 l 23 68 b 16 73 1 77 -12 77 -61 76 -89 40 -89 0 -89 -3 -89 -7 -88 -9 l -58 -9 b -51 -9 -44 -16 -42 -21 -34 -21 -27 -27 -24 -33 -14 -33 -5 -36 -1 -47 5 -51 8 -56 9 -61 l -56 -61 b -47 -68 -32 -74 -15 -74 10 -74 29 -66 48 -42 l 56 -49 b 42 -71 15 -86 -15 -85 m -61 -58 l -53 -58 b -55 -55 -60 -50 -65 -49 l -70 -49 -61 -58 m -49 -58 l -35 -58 b -37 -54 -40 -51 -45 -49 l -57 -49 -49 -58 m -30 -58 l -16 -58 b -17 -55 -22 -50 -27 -49 l -38 -49 -30 -58 m -11 -58 l 3 -58 b 1 -53 -4 -50 -10 -49 l -19 -49 -11 -58 m -74 -45 l -63 -45 b -65 -42 -68 -38 -73 -37 l -79 -37 -74 -45 m -59 -45 l -44 -45 b -47 -42 -52 -37 -56 -37 l -66 -37 -59 -45 m -40 -45 l -26 -45 b -28 -41 -32 -38 -36 -37 l -46 -37 -40 -45 m -21 -45 l -7 -45 b -9 -41 -14 -38 -19 -37 l -28 -37 -21 -45 m -81 -33 l -68 -33 b -68 -29 -74 -26 -79 -25 l -85 -25 -81 -33 m -63 -33 l -49 -33 b -50 -30 -54 -26 -59 -25 l -70 -25 -63 -33 m -44 -33 l -29 -33 b -31 -30 -35 -26 -40 -25 l -50 -25 -44 -33 m -80 -21 l -66 -21 b -68 -18 -71 -14 -77 -12 l -87 -12 b -84 -15 -81 -18 -80 -21 m -61 -21 l -47 -21 b -49 -17 -52 -14 -58 -12 l -69 -12 b -66 -15 -63 -18 -61 -21 m -85 5 b -68 10 -43 9 -28 7 l -19 -26 -13 -26 -6 -2 b 35 -23 71 -53 99 -83 97 -71 92 -58 87 -46 62 -21 31 7 -4 25 l -12 50 -16 53 -20 50 -27 29 b -41 29 -57 28 -72 25 -78 18 -83 11 -85 5 m -16 16 l -21 23 -16 37 -11 23 -16 16 m 60 19 l 60 21 54 27 39 27 b 43 21 51 18 60 19 m 56 31 l 52 40 41 40 b 44 34 50 31 56 31 m 43 31 b 41 33 38 36 37 40 l 22 40 b 23 36 29 32 34 31 l 43 31 m 49 44 l 43 52 b 41 52 39 52 37 52 41 46 45 44 49 44 m 39 56 l 28 65 b 30 60 36 56 39 56 m 31 56 l 23 65 8 65 b 12 60 15 58 19 56 l 31 56 m 12 56 l 4 65 -11 65 b -9 60 -4 57 3 56 l 12 56 m 39 44 l 33 52 18 52 b 20 48 25 45 28 44 l 39 44 m 21 44 l 14 52 0 52 b 1 48 6 45 11 44 l 21 44"


colors = [
    "&H0084FF&", "&H00CCFF&", "&HFFED00&", "&HFF2800&"
]

####### MAIN FUNCTIONS #######

def leadin(line, l):
    pass

def leadout(line, l):
    pass

def main(line, l):
    l.start_time = line.start_time
    l.end_time = line.end_time

    box = getBounding(gaim, fsc)
    shape = "m {} {} l {} {} {} {} {} {}".format(
        box[0], box[1],
        box[2], box[1],
        box[2], box[3],
        box[0], box[3],
    )

    l.text = f"{{\\an7\\p1\\pos({x},{y})}}{shape}"
    io.write_line(l)

    intervals = divideInterval(box[1]-3, box[3]+3, len(colors))
        
    for i in range(len(intervals)-1):
        for cut in range(int(intervals[i]), int(intervals[i+1])):
            clip = f"\\clip({x+box[0]},{y+cut},{x+box[2]},{y+cut+1})"
            grad = Utils.interpolate((cut-intervals[i])/(intervals[i+1]-intervals[i]), colors[i], colors[i+1])
                                     
            l.text = f"{{\\an7\\p1\\pos({x},{y}){clip}{size(fsc,fsc)}\\1c{grad}\\bord0}}{gaim}"
            io.write_line(l)

####### IMPLEMENTATION #######
for line in lines:
    l = line.copy()

    # Text
    main(line, l)
    
    cnt += 1
    print("{}/{} - {}%".format(cnt, len(lines), cnt/len(lines)*10000//1/100))

io.save()
io.open_aegisub()