from pyonfx import Ass, Shape, Convert
import numpy as np
import math
import random

frame_rate = 30.0
morph_time = 800
default_points = 100
smooth_window = 3
length_cutoff = 200.0

io = Ass("in")
meta, styles, lines = io.get_data()

def ease_in_out(t):
    return t * t * (3 - 2 * t)

class frames:
    def __init__(self, start, end, fps=frame_rate):
        self.step = 1000.0 / fps
        total = max(0, end - start)
        count = max(1, math.ceil(total / self.step))
        self.frames = [
            (int(start + i * self.step),
             int(min(start + (i + 1) * self.step, end)))
            for i in range(count)
        ]
    def __iter__(self):
        for idx, (a, b) in enumerate(self.frames):
            yield a, b, idx + 1, len(self.frames)

def create_path(char, line):
    if char.text.strip():
        s = Convert.text_to_shape(char)
        dx = char.left - line.left
        s.map(lambda x, y: (x + dx, y))
        return s
    return None

def extract_points(shape):
    pts = []
    shape.flatten().map(lambda x, y: (pts.append((x, y)), (x, y))[1])
    return pts

def resample_points(points, count=default_points):
    if len(points) < 2:
        return points * count
    d = [0.0]
    for i in range(1, len(points)):
        dx = points[i][0] - points[i - 1][0]
        dy = points[i][1] - points[i - 1][1]
        d.append(d[-1] + math.hypot(dx, dy))
    total = d[-1]
    actual = count if total <= length_cutoff else count * 2
    targets = np.linspace(0, total, actual)
    out = []
    j = 1
    for t in targets:
        while j < len(d) and d[j] < t:
            j += 1
        prev, next_ = d[j - 1], d[j]
        ratio = 0 if next_ == prev else (t - prev) / (next_ - prev)
        x = points[j - 1][0] + ratio * (points[j][0] - points[j - 1][0])
        y = points[j - 1][1] + ratio * (points[j][1] - points[j - 1][1])
        out.append((x, y))
    return out

def smooth(points, window=smooth_window):
    if len(points) < window:
        return points
    half = window // 2
    sm = []
    for i in range(len(points)):
        seg = points[max(0, i - half):min(len(points), i + half + 1)]
        x = sum(p[0] for p in seg) / len(seg)
        y = sum(p[1] for p in seg) / len(seg)
        sm.append((x, y))
    return sm

def build_shape_with_points(points):
    cmds = ""
    for i, (x, y) in enumerate(points):
        cmds += ("m" if i == 0 else "l") + f" {x:.2f} {y:.2f} "
    return Shape(cmds)

def redistribute_shapes(a_shapes, b_shapes):
    la, lb = len(a_shapes), len(b_shapes)
    if la == lb:
        return a_shapes, b_shapes
    if la < lb:
        base = lb // la
        rem  = lb % la
        expanded = []
        for idx, shp in enumerate(a_shapes):
            cnt = base + (1 if idx < rem else 0)
            pts = smooth(resample_points(extract_points(shp)))
            path = build_shape_with_points(pts)
            expanded += [path] * cnt
        return expanded, b_shapes
    else:
        base = la // lb
        rem  = la % lb
        expanded = []
        for idx, shp in enumerate(b_shapes):
            cnt = base + (1 if idx < rem else 0)
            pts = smooth(resample_points(extract_points(shp)))
            path = build_shape_with_points(pts)
            expanded += [path] * cnt
        return a_shapes, expanded

def build_path(a, b, t):
    pa = smooth(resample_points(extract_points(a)))
    pb = smooth(resample_points(extract_points(b)))
    cmds = ""
    for i, ((x1, y1), (x2, y2)) in enumerate(zip(pa, pb)):
        mx = x1 + t * (x2 - x1)
        my = y1 + t * (y2 - y1)
        cmds += ("m" if i == 0 else "l") + f" {mx:.2f} {my:.2f} "
    return Shape(cmds)

def rom_fx(line, all_lines):
    l = line.copy()
    l.start_time = line.start_time
    l.end_time = line.end_time
    y = line.top + 60
    l.text = f"{{\\an7\\shad0\\bord0\\1c&HFFFFFF&\\pos({line.left:.1f},{y:.1f})}}{line.text}"
    io.write_line(l)

    idx = all_lines.index(line)
    if idx >= len(all_lines) - 1:
        return

    next_line = all_lines[idx + 1]
    sa = [create_path(c, line)       for c in line.chars     if c.text.strip()]
    sb = [create_path(c, next_line)  for c in next_line.chars if c.text.strip()]
    if not sa or not sb:
        return

    sa, sb = redistribute_shapes(sa, sb)

    start = line.end_time
    end   = start + (line.leadout or morph_time)
    for s, e, i, n in frames(start, end):
        t = ease_in_out(i / n)
        x = line.left + t * (next_line.left - line.left)
        y = line.top  + t * (next_line.top  - line.top) + 60
        for a, b in zip(sa, sb):
            sh = build_path(a, b, t)
            l = line.copy()
            l.start_time = s
            l.end_time   = e
            l.text = f"{{\\an7\\pos({x:.1f},{y:.1f})\\p1\\1c&HFFFFFF&\\shad0\\bord0}}{sh}"
            io.write_line(l)

for line in lines:
    if not hasattr(line, "chars"):
        continue
    if line.comment:
        continue
    if line.styleref.alignment < 7:
        continue
    rom_fx(line, lines)

io.save()
io.open_aegisub()
