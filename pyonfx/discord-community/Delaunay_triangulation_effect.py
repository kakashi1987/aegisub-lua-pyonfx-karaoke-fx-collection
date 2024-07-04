from pyonfx import Ass, Convert, Utils
import numpy as np
from scipy.spatial import Delaunay
import re
import random, math
from typing import List, Tuple
import concurrent.futures

# \ ALKOON

io = Ass("in.ass")
meta, styles, lines = io.get_data()

def extract_points_from_shape(shape: str) -> List[Tuple[int, int]]:
    points = []
    commands = re.findall(r'[mlb]\s+((?:-?\d+\s*-?\d+\s*)+)', shape)
    for command in commands:
        coords = [int(n) for n in re.findall(r'-?\d+', command)]
        if len(coords) % 2 != 0:
            print(f"Malformed command in shape: {command}")
            continue
        for i in range(0, len(coords), 2):
            points.append((coords[i], coords[i + 1]))
    return points

def is_point_in_polygon(x: float, y: float, polygon: List[Tuple[int, int]]) -> bool:
    num = len(polygon)
    j = num - 1
    c = False
    for i in range(num):
        if ((polygon[i][1] > y) != (polygon[j][1] > y)) and \
                (x < (polygon[j][0] - polygon[i][0]) * (y - polygon[i][1]) / (polygon[j][1] - polygon[i][1]) + polygon[i][0]):
            c = not c
        j = i
    return c

def round_shape_coordinates(shape: str) -> str:
    rounded_shape = ''
    for part in shape.split():
        if part in ['m', 'l', 'b']:
            rounded_shape += part + ' '
        else:
            coords = part.split()
            for coord in coords:
                rounded_coord = str(int(round(float(coord))))
                rounded_shape += rounded_coord + ' '
    return rounded_shape.strip()

def colors_mx(x: int, y: int) -> str:
    r = (x * y) % 256
    g = (x + y) % 256
    b = (x * 2 + y) % 256
    r = int(r * 0.8)
    g = int(g * 0.8)
    b = int(b * 0.8)
    color = f"&H{b:02X}{g:02X}{r:02X}&"
    return color

def delaunay_effect(line, io: Ass) -> None:
    for char in Utils.all_non_empty(line.chars):

        shape = Convert.text_to_shape(char)
        rounded_shape = round_shape_coordinates(str(shape))
        points = extract_points_from_shape(rounded_shape)

        if len(points) < 3:
            continue

        delaunay = Delaunay(np.array(points))
        triangles = delaunay.simplices
        num_triangles = len(triangles)

        for i, triangle in enumerate(triangles):
            vertices = [points[index] for index in triangle]
            centroid = np.mean(vertices, axis=0)
            if is_point_in_polygon(centroid[0], centroid[1], points):
                delay = i * (char.duration / num_triangles)
                color = colors_mx(int(centroid[0]), int(centroid[1]))


                l = line.copy()
                l.start_time =  line.start_time +char.i * 35 -random.uniform(190,250)
                l.end_time =  line.start_time + char.start_time + char.duration +50 + i * (((char.duration/2) + 450) / num_triangles)
                rx, ry  = random.uniform(-40,40),  random.uniform(-10,10) 

                drawing = "m {} {} l {} {} {} {} {} {}".format(
                    vertices[0][0], vertices[0][1],
                    vertices[1][0], vertices[1][1],
                    vertices[2][0], vertices[2][1],
                    vertices[0][0], vertices[0][1])

                l.text = f"{{\\an7\\3c{color}\\fad(70,0)\\1c{color}\\bord0.4\\be0.4\\move({char.left+rx},{line.top+ry},{char.left},{line.top},0,180)\\p1}}{drawing}"
                l.effect = "IN_FX"
                io.write_line(l)

                l.start_time = line.start_time + char.duration+  char.start_time +50 +  i * (((char.duration/2) + 450) / num_triangles) 
                l.end_time =  l.start_time + 350 
                l.text = f"{{\\an7\\3c&HFFFFFF&\\1a&HFF&\\1c{color}\\fad(0,60)\\bord0.6\\be0.2\\move({char.left},{line.y},{char.left},{line.y})\\p1}}{drawing}"
                io.write_line(l)

                l.start_time = line.start_time + char.duration+  char.start_time +50 +  i * (((char.duration/2) + 450) / num_triangles)
                l.end_time =  l.start_time + 350 
                tt = random.uniform(40,60)   
                l.text = f"{{\\an7\\3c{color}\\1c{color}\\fad(0,60)\\bord0.4\\be0.2\\move({char.left},{line.y},{char.left},{line.y+tt})\\p1}}{drawing}"
                io.write_line(l)

                l.start_time =  line.start_time + char.start_time + 15 + i * (char.duration  / num_triangles)
                l.end_time = l.start_time + 200
                l.effect = "KFX"
                l.text = f"{{\\an7\\3c&HFFFFFF&\\bord0.6\\fad(0,50)\\1a&HFF&\\pos({char.left},{line.top})\\p1}}{drawing}"
                l.layer = 1
                io.write_line(l)

def process_line(line) -> None:
    if not line.comment:
        delaunay_effect(line, io)

 
if len(lines) > 10: 
    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.map(process_line, lines)
else:
    for line in lines:
        process_line(line)

io.save()
io.open_aegisub()
