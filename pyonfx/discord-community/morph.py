from pyonfx import *
import math
import random
# ALKOON 

io = Ass("in2.ass")
meta, styles, lines = io.get_data()

def equalize_path_sizes(path_a, path_b):
    while len(path_a) != len(path_b):
        shorter_path = path_a if len(path_a) < len(path_b) else path_b
        random_index = random.randint(1, len(shorter_path) - 2)
        duplicate_point = shorter_path[random_index]
        shorter_path.insert(random_index, duplicate_point)

def get_shape_points(shape):
    collected_points = []
    shape.map(lambda x, y: collected_points.append((x, y)))
    return collected_points

def morph_shapes(shape_a, shape_b, pct):
    points_a = get_shape_points(shape_a)
    points_b = get_shape_points(shape_b)

    max_length = max(len(points_a), len(points_b))

    ######### Extend both paths to the maximum length ##########
    while len(points_a) < max_length:
        points_a.append(points_a[-1])
    while len(points_b) < max_length:
        points_b.append(points_b[-1])

    drawing_cmds = ""
    for index in range(max_length):
        x1, y1 = points_a[index]
        x2, y2 = points_b[index]
        new_x = x1 + pct * (x2 - x1)
        new_y = y1 + pct * (y2 - y1)
        cmd = 'l' if index > 0 else 'm'
        drawing_cmds += f"{cmd} {new_x} {new_y} "

    return Shape(drawing_cmds)

    return Shape(drawing_cmds)
def create_path(char, line):
    if char.text != " ":
        char_shape = Convert.text_to_shape(char).split()  
        displacement = (char.left - line.left) 
        char_shape.map(lambda x, y: (x + displacement, y))
        return char_shape
    return None

def romaji(line, l):
    if line.i != len(lines) - 1:
        cur_path = [create_path(char, line) for char in line.chars]
        next_path = [create_path(char, lines[line.i + 1]) for char in lines[line.i + 1].chars]

        cur_path = [shape for shape in cur_path if shape is not None]
        next_path = [shape for shape in next_path if shape is not None]

        fu = FrameUtility(line.end_time, line.end_time + line.leadout, 35.71)
        for s, e, i, n in fu:
            for ci in range(min(len(cur_path), len(next_path))):
                l.start_time = s
                l.end_time = e
                pct = i / n
                morphed_shape = morph_shapes(cur_path[ci], next_path[ci], pct)
                l.text = f"{{\\an7\\1c&H535616&\\shad0\\bord0\\pos({line.left:.3f},{line.top:.3f})\\p1}}{morphed_shape}"
                io.write_line(l)

for line in lines:
    romaji(line, line.copy())

io.save()
io.open_aegisub()
