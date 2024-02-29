from pyonfx import *
import random, os, math
dir_path = os.path.dirname(os.path.realpath(__file__))
name = "Text-Breaking"
io = Ass(name + ".ass", name + " - Gen.ass")
meta, styles, lines = io.get_data()

def pairs(o):
    if isinstance(o,dict):
        return o.items()
    else:
        return enumerate(o)

star_color = "&H2ADEFF&"

random.seed(7)
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

    def write_clip(clip_arr):
        cliptext = ""
        for i, pt in enumerate(clip_arr):
            if i == 0:
                cliptext += "m"
            elif i == 1:
                cliptext += " l"
            cliptext += f" {pt['x']} {pt['y']}"
        return cliptext
    
    def translate_clip(clip_arr, tx, ty):
        newclip = []
        for i, pt in enumerate(clip_arr):
            newclip.append({
                'x': pt['x'] + tx, 
                'y': pt['y'] + ty
            })
        return newclip

    def rotate_clip(clip_arr, o, frz):
        rad = -frz * math.pi / 180
        newclip = []
        for i, pt in enumerate(clip_arr):
            tx = pt['x'] - o['x']
            ty = pt['y'] - o['y']
            newclip.append({
                'x': o['x'] + math.cos(rad) * tx - math.sin(rad) * ty, 
                'y': o['y'] + math.sin(rad) * tx + math.cos(rad) * ty
            })
        return newclip
    
    def rayxrect(o, t, topleft, botright):
        lx = topleft['x'] if t['x'] < o['x'] else botright['x']
        ly = topleft['y'] if t['y'] < o['y'] else botright['y']

        xinty = o['y'] + (t['y'] - o['y']) / (t['x'] - o['x']) * (lx - o['x'])
        yintx = o['x'] + (t['x'] - o['x']) / (t['y'] - o['y']) * (ly - o['y'])
        
        return {'x': lx, 'y': xinty} if ((o['y'] <= xinty and xinty <= ly) or (o['y'] >= xinty and xinty >= ly)) else {'x': yintx, 'y': ly}

    # Main
    l.start_time = line.start_time
    l.end_time = line.end_time - 400

    l.text = f"{{\\an5\\pos({line.center},{line.middle})}}{line.text}"
    io.write_line(l)

    # Leadout - Text Breaking - Still working on it
    for char in line.chars:
        break_len = 1000
        break_speed = 20
        break_rotspeed = (-1)**char.i * random.randint(3, 20)
        break_gravity = 2
        break_o_variance = 5
        break_px = char.center
        break_py = char.middle
        break_o = {'x': break_px + random.randint(-break_o_variance, break_o_variance), 
                   'y': break_py + random.randint(-break_o_variance, break_o_variance)}
        break_n = random.choice([3, 4, 5, 6])
        break_a_abs = random.randint(0, 360)
        break_a_variance = 7
        break_info = {}

        for i in range(break_n):
            a = (i*(360/break_n) + random.randint(-break_a_variance, break_a_variance) + break_a_abs) * math.pi/180
            rp = {'x': break_o['x'] + break_len*math.cos(a), 'y': break_o['y'] + break_len*math.sin(a)}
            rectint = rayxrect(break_o, rp, {'x': char.left, 'y': line.top}, {'x': char.right, 'y': line.bottom})
            break_info[i] = {'angle': a, 'rp': rp, 'rectint': rectint, 'rotspeed': break_rotspeed * random.uniform(0.7, 1.2)}

        for i in range(break_n):
            break_info[i]['clip'] = [break_o, break_info[i]['rp'], break_info[(i + 1) % break_n]['rp']]
            break_info[i]['centroid'] = {
                'x': (break_o['x'] + break_info[i]['rectint']['x'] + break_info[(i + 1) % break_n]['rectint']['x'])/3, 
                'y': (break_o['y'] + break_info[i]['rectint']['y'] + break_info[(i + 1) % break_n]['rectint']['y'])/3
            }

        delay = 400
        for piece in range(break_n):
            FU = FrameUtility(line.end_time - delay, line.end_time + delay)
            for s, e, i, n in FU:
                l.start_time = s
                l.end_time = e

                info = break_info[piece]

                tx = break_speed * i * math.cos(info['angle'])
                ty = break_speed * i * math.sin(info['angle']) + break_gravity * i ** 2
                frz = info['rotspeed'] * i

                clip = write_clip(rotate_clip(translate_clip(info['clip'], tx, ty), {'x' : info['centroid']['x'] + tx, 'y' : info['centroid']['y'] + ty}, frz))

                # Generate line here
                l.text = "{\\an5\\org(%.1f,%.1f)\\pos(%.1f,%.1f)\\clip(%s)\\frz%d}%s" % (
                    info['centroid']['x'] + tx, info['centroid']['y'] + ty,
                    break_px + tx, break_py + ty,
                    clip,
                    frz,
                    char.text
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
io.open_aegisub()